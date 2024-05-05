//
//  ContentView.swift
//  ElasticSegmentControl
//
//  Created by Nap Works on 02/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: SegmentedTab = .home
    @State private var type2: Bool = false
    var body: some View {
        NavigationStack {
            VStack (spacing: 15){
                SegmentedControl(
                    tabs: SegmentedTab.allCases,
                    activeTab: $activeTab,
                    height: 35,
                    font: .body,
                    activeTint: type2 ? .white : .primary,
                    inActiveTint: .gray.opacity(0.5)
                ) { size in
                    RoundedRectangle(cornerRadius: type2 ? 30 : 0)
                        .fill(.blue)
                        .frame(height: type2 ? size.height : 4)
                        .padding(.horizontal, type2 ? 0 : 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .padding(.top, type2 ? 0 : 10)
                .background {
                    RoundedRectangle(cornerRadius: type2 ? 30 : 0)
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                }
                .padding(.horizontal, type2 ? 15 : 0)
                
                Toggle("Segmented Control Type - 2", isOn: $type2)
                    .padding(10)
                    .background(.regularMaterial, in: .rect(cornerRadius: 10))
                    .padding(15)
                
                TabView(selection: $activeTab){
                    ForEach(SegmentedTab.allCases, id: \.rawValue){ tab in
                        Image(systemName: tab.rawValue)
                            .tag(tab)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer(minLength: 0)
            }
            .padding(.vertical, type2 ? 15 : 0)
            .animation(.snappy, value: type2)
            .navigationTitle("Segmented Control")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}

enum SegmentedTab: String, CaseIterable {
    case home = "house.fill"
    case favourites = "suit.heart.fill"
    case notifications = "bell.fill"
    case profile = "person.fill"
}
