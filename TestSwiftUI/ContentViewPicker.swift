//
//  ContentViewPicker.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/10/25.
//

import SwiftUI

enum Spread: CaseIterable, Hashable, Identifiable {
    var id: Self { self }

    case none
    case almondButter
    case PeanutButter
    case Dep1
    case Dep2
    case Dep3
    case Dep4
    case Dep5
    case Dep6
    case Dep7
    case Dep8
    case Dep9
    case Dep10
    case Dep11
    case Dep12
    case Dep13
    case Dep14
    case Dep15
}

struct HomeViewPicker: View {
    @State private var spread: Spread = .none
    var body: some View {
        
        Form {
            Section {
                Picker(selection: $spread, label: Text("Bread")) {
                    ForEach(Spread.allCases) { flavor in
                        Text(String(describing: flavor))
                    }
                }
            }
        }
        .environment(\.isEnabled, spread != .Dep1)
    }
}

enum SpreadMenu: CaseIterable, Hashable, Identifiable {
    case none
    case almondButter
    case peanutButter

    var id: Self { self }

    var displayName: String {
        switch self {
        case .none: return "None"
        case .almondButter: return "Almond Butter"
        case .peanutButter: return "Peanut Butter"
        }
    }
}
struct HomeViewPickerMenu: View {
    @State private var spread: SpreadMenu = .none
    var body: some View {
        
        Menu {
            Picker(selection: $spread, label: EmptyView()) {
                ForEach(SpreadMenu.allCases) { spread in
                    Text(spread.displayName)
                        .tag(spread)
                }
            }
            
        } label: {
            // Giao diện bạn tự thiết kế, không còn mũi tên mặc định
            Text(spread.displayName)
                .font(.body)
                .foregroundColor(.primary)
        }    }
}

//@main
//struct HomeViewPickerApp: App {
//    var body: some Scene {
//        WindowGroup {
//          //  HomeViewPicker()
//            HomeViewPicker()
//        }
//    }
//}
//
