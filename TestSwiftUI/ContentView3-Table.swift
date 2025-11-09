//
//  ContentView3-Table.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/9/25.
//

import SwiftUI

struct Employee: Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var skills: [Skill]
}

struct Skill: Identifiable {
    var id: String {
        return name
    }
    var name: String
}

struct ContentTableView: View {
    let employees = [
        Employee(name: "Alice", age: 28,skills: [Skill(name: "java"), Skill(name: "android")]),
        Employee(name: "Bob", age: 34, skills: [Skill(name: "swift"), Skill(name: "ios")])
    ]
    
    var body: some View {
        Table(employees) {
            TableColumn("Name") { emp in
                Text(emp.name)
            }
            TableColumn("Age") { emp in
                Text("\(emp.age)")
            }
        }
    }
}

struct ContentListView: View {
    @State private var employees: [Employee] = [
        Employee(name: "Alice", age: 28,skills: [Skill(name: "java"), Skill(name: "android")]),
        Employee(name: "Bob", age: 34, skills: [Skill(name: "swift"), Skill(name: "ios")])
    ]

    
    var body: some View {
        VStack{
            Button("Add", action: {
                employees.append(Employee(name: "Alice", age: 28,skills: [Skill(name: "java"), Skill(name: "android")]))
            }).frame(height: 40)
            List(employees) {
                ListViewCell(employ: $0)
            }
        }
    }
}

struct ListViewCell: View {
    var employ : Employee
    
    var body: some View {
        return HStack {
            Text(employ.name)
            Spacer()
            Text("\(employ.age)")
            Spacer()
            ForEach(employ.skills) {
                Text($0.name)
            }
        }
    }
}

//@main
//struct DeeplinkRouterApp: App {
//    
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentListView()
//        }
//    }
//}
//
