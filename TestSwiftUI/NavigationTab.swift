//
//  NavigationTab.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/10/25.
//

import SwiftUI

//Tab in navigation stack

struct HomeViewNavigationTab: View {
    @State private var spread: Spread = .none
    var body: some View {
        
        NavigationStack {
            TabView {
                Form {
                    Text("Hello, World!")
                    NavigationLink("Bread") {
                        Text("Choose Bread Type")
                    }
                }
                Form {
                    Text("Hello, World! 11")
                }
            }
        }
    }
}

//navigation stack in tabview

struct HomeViewTabNavigation: View {
    @State private var spread: Spread = .none
    var body: some View {
        
        
        TabView {
            NavigationStack {
                Form {
                    Text("Hello, World!")
                    NavigationLink("Bread") {
                        Text("Choose Bread Type")
                    }
                }
            }
            
            Form {
                Text("Hello, World! 11")
            }
        }
        
    }
}

@main
struct NavigationTabApp: App {
    var body: some Scene {
        WindowGroup {
            //  HomeViewPicker()
            HomeViewTabNavigation()
        }
    }
}
