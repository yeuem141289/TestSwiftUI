//
//  TestMac.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/12/25.
//

import SwiftUI

enum Tab: String {
    case explore
    case hikes
    case tours
}

struct ContentViewMac: View {
    @AppStorage("selectedTab") private var selectedTab: Tab = .explore
    
    var body: some View {
        Text("fsfsd").onTapGesture(count: 2, perform: {
            print("yeu em")
        }) 
    }
}

//@main
//struct TestSwiftUIApp: App {
//    @AppStorage("selectedTab") private var selectedTab: Tab = .explore
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentViewMac()
//        }
//      
//    }
//}


struct ExploreView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe.europe.africa.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            Text("Explore")
                .font(.largeTitle)
                .bold()
            Text("Discover new places, adventures, and destinations.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}


struct HikesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.walk.motion")
                .font(.system(size: 60))
                .foregroundColor(.green)
            Text("Hikes")
                .font(.largeTitle)
                .bold()
            Text("Track your favorite hiking routes and trails.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

struct ToursView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "map.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            Text("Tours")
                .font(.largeTitle)
                .bold()
            Text("Plan and organize guided tours with ease.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

