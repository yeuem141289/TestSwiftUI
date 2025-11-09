//
//  ContentViewGroup.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/9/25.
//

import SwiftUI



struct FormSection: Identifiable {
    let id = UUID()
    let name: String
    let rowNames: [String]
}

struct ContentFormView: View {
    let employees = [
        FormSection(name: "Section 1", rowNames: ["Row 1", "Row 1"]),
        FormSection(name: "Section 2", rowNames: ["Row 2", "Row 2"])
    ]
    
    @State private var selectedRow: String? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(employees) { section in
                    Section(header: Text(section.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))) {
                            VStack(spacing: 0) {
                                ForEach(section.rowNames, id: \.self) { rowName in
                                    Button {
                                        // 👇 Chỉ gán giá trị 1 lần khi user tap
                                        selectedRow = rowName
                                    } label: {
                                        ContentFormCell(name: rowName)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .textCase(nil) // Giữ nguyên font header
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                    
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .listStyle(.plain)
            .navigationTitle("abcd")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)     // bỏ nền xám bo góc
            .background(Color(red: 247/255, green: 249/255, blue: 250/255)) // nền phẳng
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(isPresented: Binding(
                get: { selectedRow != nil },
                set: { if !$0 { selectedRow = nil } }
            )) {
                if let row = selectedRow {
                    Text("\(row) Detail")
                        .font(.system(size: 18, weight: .medium))
                        .navigationTitle(row)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct ContentFormSection: View {
    var name: String
    var cell: [ContentFormCell]
    var body: some View {
        Text(name)
        VStack{
            ForEach(cell) { cell in
                cell
            }
        }
    }
}

struct ContentFormCell: View, Identifiable {
    let id = UUID()
    var name: String
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(name)
                    .font(.system(size: 14))
                Spacer()
                Image("icon-arrow-right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }.frame(height: 44).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            Divider().background(Color.gray.opacity(0.3))
        }.background(.white)
    }
}

@main
struct DeeplinkRouterApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentFormView()
        }
    }
}

