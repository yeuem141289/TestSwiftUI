//
//  ContentViewData.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/16/25.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var score: Int = 0
   // var score1: Int = 0
}

struct ContentViewData: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationStack {
            VStack {
                Text("Score: \(settings.score)")
                    .font(.largeTitle)

                NavigationLink("Go to Detail View") {
                    DetailView()
                }
            }
        }
    }
}

struct DetailView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        VStack {
            Text("Increase Score")
                .font(.title)

            Button("Add 1") {
                settings.score += 1
            }
        }
    }
}

@main
struct DemoApp: App {
    @StateObject var settings = UserSettings()

    var body: some Scene {
        WindowGroup {
            ContentViewData()
                .environmentObject(settings)
        }
    }
}
