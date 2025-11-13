//
//  ContentEmbedUIKitinSwiftUI.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/13/25.
//

import SwiftUI

struct RatingsControlRepresentation: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(rating: $rating)
    }
    
    class Coordinator: NSObject {
        @Binding var rating: Int
        init(rating: Binding<Int>) {
            self._rating = rating
        }
        @objc func ratingChanged(_ sender: HCSStarRatingView) {
            self.rating = Int(sender.value)
        }
    }

    @Binding var rating: Int
    
    func makeUIView(context: Context) -> HCSStarRatingView {
        let ratingControl = HCSStarRatingView()
        ratingControl.maximumValue = 5
        ratingControl.minimumValue = 0
        ratingControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.ratingChanged(_:)),
            for: .valueChanged
        )
        return ratingControl
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("updateUIView")
    }
    
    
}


struct HomeViewEmbedUIKit: View {
    @State private var rating: Int = 0
    var body: some View {
        VStack {
            RatingsControlRepresentation(rating: $rating).frame(width: 100, height: 20)
            Text("\(self.rating)")
        }
    }
}


@main
struct DeeplinkRouterApp: App {

    var body: some Scene {
        WindowGroup {
            HomeViewEmbedUIKit()
        }
    }
}
