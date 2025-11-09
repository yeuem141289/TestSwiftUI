//
//  ContentViewGroup.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/9/25.
//

import SwiftUI
import SwiftUIIntrospect


struct FormSection: Identifiable {
    let id = UUID()
    let name: String
    let rowNames: [String]
}

struct ContentFormView: View {
    let employees = [
        FormSection(name: "Section 1", rowNames: ["Row 1", "Row 1"]),
        FormSection(name: "Section 2", rowNames: ["Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2", "Row 2"])
    ]
    
    @State private var selectedRow: String? = nil
    @State private var isList: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomNavBar(title: "fdsfsdf")
                if #available(iOS 17.0, *) {
                    List {
                        sectionsContent
                    } .listStyle(.plain)
                        .navigationBarTitleDisplayMode(.inline)
                        .scrollContentBackground(.hidden)
                        .environment(\.defaultMinListHeaderHeight, 0)
                        .scrollBounceBehavior(.basedOnSize)
                } else {
                    List {
                        sectionsContent
                    } .listStyle(.plain)
                        .navigationBarTitleDisplayMode(.inline)
                        .scrollContentBackground(.hidden)
                        .environment(\.defaultMinListHeaderHeight, 0)
                        .introspect(.scrollView, on: .iOS(.v16)) { scrollView in
                            // Disable scrolling if content size is smaller than the container size
                            if scrollView.contentSize.height < scrollView.bounds.height {
                                scrollView.isScrollEnabled = false
                            }
                        }
                }
            }
            .background(Color(red: 247/255, green: 249/255, blue: 250/255)) // nền phẳng
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
            }.navigationBarHidden(true)
            .ignoresSafeArea(.container, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var sectionsContent: some View {
        ForEach(employees) { section in
            Section(header:   HStack {
                Text(section.name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                Spacer()}.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)),
                    footer: EmptyView()
            ) {
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

