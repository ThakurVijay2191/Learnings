//
//  TabView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0
    @State private var showCreateThreadView: Bool = false
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }.tag(0)
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }.tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }.tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }.tag(4)
        })
        .onChange(of: selectedTab, { oldValue, newValue in
            showCreateThreadView = selectedTab == 2
        })
        .sheet(isPresented: $showCreateThreadView, onDismiss: {
            selectedTab = 0
        }, content: {
            ThreadCreationView(showCreateThreadView: $showCreateThreadView)
                .interactiveDismissDisabled()
        })
        .tint(.black)
    }
}

#Preview {
    TabBarView()
}
