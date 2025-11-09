//
//  ContentView1.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/8/25.
//
import SwiftUI

struct HomeView1: View {
    @State private var searchText: String = ""
    var body: some View {
        TextField("email", text: $searchText)
            .padding(.all)
            .background(Color.green).padding(.all)
            .cornerRadius(10)
    }
}

//@main
//struct DeeplinkRouterApp: App {
//    
//
//    var body: some Scene {
//        WindowGroup {
//            HomeView1()
//        }
//    }
//}
//
