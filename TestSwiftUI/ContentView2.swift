////
////  ContentView2.swift
////  TestSwiftUI
////
////  Created by nguyen tuan dang on 11/8/25.
////
//
////
////  CustomTabBarExample.swift
////  SwiftUICustomTabBar
////
////  Created by ChatGPT on 2025-11-08.
////
//
//import SwiftUI
//
//// MARK: - Model cho mỗi tab
//struct TabItem: Hashable {
//    var icon: String
//    var title: String
//    var color: Color
//}
//
//// MARK: - View chính chứa nội dung và TabBar
//struct CustomTabView: View {
//    @State private var selectedTab: TabItem
//    
//    private let tabs: [TabItem]
//    private let content: [AnyView]
//    
//    private var bottomSafeArea: CGFloat {
//        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        let window = windowScene?.windows.first
//        return window?.safeAreaInsets.bottom ?? 0
//    }
//    
//    init(tabs: [TabItem], content: [AnyView], defaultTab: TabItem) {
//        self.tabs = tabs
//        self.content = content
//        _selectedTab = State(initialValue: defaultTab)
//    }
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            GeometryReader { geo in
//                
//                VStack(spacing: 0) {
//                    // Nội dung chính
//                    ZStack {
//                        ForEach(Array(zip(tabs, content)), id: \.0) { tab, view in
//                            if tab == selectedTab {
//                                view
//                                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
//                                    .transition(.opacity)
//                            }
//                        }
//                    }
//                    .frame(maxHeight: .infinity)
//                    
//                    // Tab bar luôn cố định ở dưới, nằm trên safe area
//                    Divider()
//                    CustomTabBar(tabs: tabs, selectedTab: $selectedTab)
//                        .frame(height: 60)
//                        .frame(maxWidth: .infinity)
//                        .background(.ultraThinMaterial)
//                }
//                // cho phép keyboard đè nội dung, không đè tab bar
//                .ignoresSafeArea(.keyboard, edges: .bottom)
//            }
//            Color.clear.frame(height: bottomSafeArea)
//        }
//    }
//}
//
//
//// MARK: - TabBar hiển thị ở dưới cùng
//struct CustomTabBar: View {
//    let tabs: [TabItem]
//    @Binding var selectedTab: TabItem
//    @Namespace private var animation
//    
//    var body: some View {
//        HStack {
//            ForEach(tabs, id: \.self) { tab in
//                Button {
//                    withAnimation(.spring()) {
//                        selectedTab = tab
//                    }
//                } label: {
//                    VStack(spacing: 4) {
//                        Image(systemName: tab.icon)
//                            .font(.system(size: 20, weight: .semibold))
//                            .foregroundColor(selectedTab == tab ? tab.color : .gray)
//                        
//                        Text(tab.title)
//                            .font(.system(size: 12, weight: .medium))
//                            .foregroundColor(selectedTab == tab ? tab.color : .gray)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//                    .background(
//                        ZStack {
//                            if selectedTab == tab {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(tab.color.opacity(0.15))
//                                    .matchedGeometryEffect(id: "tab_bg", in: animation)
//                            }
//                        }
//                    )
//                }
//            }
//        }
//        .padding(.horizontal, 12)
//        .padding(.bottom, 10)
//        .background(.ultraThinMaterial)
//    }
//}
//
//// MARK: - Các View của từng tab
//struct HomeView2: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("🏠 Trang chủ")
//                    .font(.largeTitle.bold())
//                    .padding(.top, 20)
//                Text("Nội dung tab 1 ở đây...")
//            }
//        }
//    }
//}
//
//struct SettingsView2: View {
//    var body: some View {
//        VStack {
//            Text("⚙️ Cài đặt")
//                .font(.largeTitle.bold())
//                .padding(.top, 20)
//            Text("Cấu hình ứng dụng của bạn.")
//        }
//    }
//}
//
//struct ProfileView2: View {
//    var body: some View {
//        VStack {
//            Text("👤 Hồ sơ")
//                .font(.largeTitle.bold())
//                .padding(.top, 20)
//            Text("Thông tin cá nhân người dùng.")
//        }
//    }
//}
//
//// MARK: - Gộp tất cả lại thành App chính
//struct ContentView: View {
//    private let tabs: [TabItem] = [
//        .init(icon: "house.fill", title: "Trang chủ", color: .blue),
//        .init(icon: "gearshape.fill", title: "Cài đặt", color: .orange),
//        .init(icon: "person.crop.circle.fill", title: "Hồ sơ", color: .purple)
//    ]
//    
//    private let views: [AnyView] = [
//        AnyView(HomeView2()),
//        AnyView(SettingsView2()),
//        AnyView(ProfileView2())
//    ]
//    
//    var body: some View {
//        CustomTabView(
//            tabs: tabs,
//            content: views,
//            defaultTab: .init(icon: "house.fill", title: "Trang chủ", color: .blue)
//        )
//    }
//}
//
////@main
////struct DeeplinkRouterApp: App {
////    
////    
////    var body: some Scene {
////        WindowGroup {
////            ContentView()
////        }
////    }
////}
////
