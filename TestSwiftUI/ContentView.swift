import SwiftUI
//import UserNotifications
//import Combine
//
//// MARK: - Enum tab chính của ứng dụng
//enum AppTab: Hashable {
//    case home
//    case notification
//}
//
//// MARK: - Enum các đích điều hướng
//enum DeeplinkDestination: Equatable {
//    case timeline
//    case profile(String)
//    case payment
//    case popupPayment // ví dụ mở popup
//}
//
//// MARK: - Router điều hướng trung tâm
//@MainActor
//final class DeeplinkRouter: ObservableObject {
//    static let shared = DeeplinkRouter()
//    
//    @Published var destination: DeeplinkDestination? = nil
//    @Published var selectedTab: AppTab = .home
//    @Published var showSheet: Bool = false
//    
//    // MARK: - Mở deeplink
//    func openUrl(_ url: String) {
//        print("🧭 Deeplink mở URL: \(url)")
//        if url.contains("timeline") {
//            destination = .timeline
//        } else if url.contains("profile-") {
//            let id = url.components(separatedBy: "-").last ?? "unknown"
//            destination = .profile(id)
//        } else if url.contains("payment") {
//            destination = .payment
//        } else if url.contains("popup") {
//            showSheet = true
//        } else if url.contains("home") {
//            selectedTab = .home
//        }
//    }
//    
//    func clear() {
//        destination = nil
//    }
//    
//    // MARK: - View đích (đã tách khỏi RootView)
//    @ViewBuilder
//    func destinationView() -> some View {
//        switch destination {
//        case .timeline:
//            TimelineView()
//        case .profile(_):
//            ProfileView()
//        case .payment:
//            PaymentView()
//        case .none:
//            EmptyView()
//        case .popupPayment:
//            PaymentView()
//        }
//    }
//}
//
//// MARK: - Cầu nối gọi từ class non-SwiftUI (UIKit, Manager, v.v.)
//class Deeplink {
//    static func openUrl(_ url: String) {
//        DispatchQueue.main.async {
//            DeeplinkRouter.shared.openUrl(url)
//        }
//    }
//}
//
//// MARK: - NotificationManager (Test Local Notification)
//final class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
//    static let shared = LocalNotificationManager()
//    
//    func requestPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
//            print(granted ? "✅ Notification allowed" : "❌ Denied")
//        }
//        UNUserNotificationCenter.current().delegate = self
//    }
//    
//    func scheduleTestNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Deeplink Test"
//        content.body = "Tap to open Timeline"
//        content.userInfo = ["deeplink": "app://timeline"]
//        content.sound = .default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//        let request = UNNotificationRequest(identifier: "deeplink_test", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//        print("🔔 Notification sẽ hiện sau 3 giây")
//    }
//    
//    // Khi user bấm notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let url = userInfo["deeplink"] as? String {
//            Deeplink.openUrl(url)
//        }
//        completionHandler()
//    }
//}
//
//// MARK: - RootView chính của ứng dụng
//struct RootView: View {
//    @StateObject private var router = DeeplinkRouter.shared
//    
//    var body: some View {
//        NavigationView {
//            TabView(selection: $router.selectedTab) {
//                HomeView()
//                    .tabItem { Label("Home", systemImage: "house") }
//                    .tag(AppTab.home)
//                
//                NotificationView()
//                    .tabItem { Label("Notification", systemImage: "bell") }
//                    .tag(AppTab.notification)
//            }
//            // 🔗 NavigationLink điều khiển bằng Binding custom
//            .background(
//                NavigationLink(
//                    destination: router.destinationView().navigationBarBackButtonHidden(),
//                    isActive: Binding(
//                        get: { router.destination != nil },
//                        set: { if !$0 { router.clear() } }
//                    ),
//                    label: { EmptyView() }
//                )
//                .hidden()
//            )
//            // 🔄 Sheet nếu có popup
//            .sheet(isPresented: $router.showSheet) {
//                PaymentView()
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .onAppear {
//            LocalNotificationManager.shared.requestPermission()
//        }
//    }
//}
//
//// MARK: - Các view demo
//struct HomeView: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("🏠 Home View").font(.title)
//            Button("🧭 Đi tới Timeline") {
//                Deeplink.openUrl("app://timeline")
//            }
//            Button("👤 Đi tới Profile-123") {
//                Deeplink.openUrl("app://profile-123")
//            }
//            Button("💳 Đi tới Payment") {
//                Deeplink.openUrl("app://payment")
//            }
//            Button("💬 Mở popup Payment") {
//                Deeplink.openUrl("app://popup")
//            }
//            Button("🔔 Gửi Local Notification") {
//                LocalNotificationManager.shared.scheduleTestNotification()
//            }
//        }
//        .padding()
//    }
//}
//
//struct NotificationView: View {
//    var body: some View {
//        Text("🔔 Notification View").font(.title)
//    }
//}
//
//struct TimelineView: View {
//    var body: some View {
//        Text("🕒 Timeline View").font(.title)
//    }
//}
//
//struct ProfileView: View {
//    @Environment(\.dismiss) private var dismiss
//    var body: some View {
//        VStack(spacing: 0) {
//            CustomNavBar(title: "Trang cá nhân Trang cá nhân Trang cá nhân Trang cá nhân Trang cá nhân Trang cá nhân") {
//                dismiss()
//            }
//            ScrollView {
//                Text("Nội dung hồ sơ...")
//                    .padding()
//            }
//        }
//        .ignoresSafeArea(edges: .top)
//    }
//}
//
//struct PaymentView: View {
//    var body: some View {
//        VStack {
//            Text("💳 Payment View").font(.title)
//            Text("Màn hình thanh toán hoặc popup")
//        }
//        .padding()
//    }
//}
//
//// MARK: - Entry Point
////@main
////struct DeeplinkRouterApp: App {
////    init() {
////        UNUserNotificationCenter.current().delegate = LocalNotificationManager.shared
////    }
////
////    var body: some Scene {
////        WindowGroup {
////            RootView()
////        }
////    }
////}
//
struct CustomNavBar: View {
    var title: String
    var onBack: (() -> Void)?
    
    private var topSafeArea: CGFloat {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Safe area trên (tai thỏ)
            Color.clear.frame(height: topSafeArea)
            
            ZStack {
                // 🔹 Title ở giữa ZStack
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 60)
                    .lineLimit(1)
                
                // 🔹 Nút back nằm chồng lên (align trái)
                HStack {
                    Button(action: { onBack?() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: { onBack?() }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 44)
            .background(Color.blue)
        }
        .background(Color.blue)
    }
}
