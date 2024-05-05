//
//  Home.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 16/09/23.
//

import SwiftUI

struct Home: View {
    @State var selectedTab: String = "house.fill"
    @Environment(\.colorScheme) var scheme
    @Binding var offset: CGFloat
    
    var body: some View {
        TabView(selection: $selectedTab){
            FeedView(offset: $offset)
                .padding(.top, edges?.top)
                .padding(.bottom, 60)
                .tag("house.fill")
            
            Text("Search")
                .tag("magnifyingglass")
            
            Text("Reels")
                .tag("airplayvideo")
            
            Text("Notifications")
                .tag("suit.heart.fill")
            
            Text("Settings")
                .tag("person.circle.fill")
        }
        .overlay (
            VStack(spacing: 0){
                Divider()
                    .padding(.horizontal, -15)
                
                HStack(spacing: 0){
                    TabBarButton(image: "house.fill", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(image: "magnifyingglass", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(image: "airplayvideo", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(image: "suit.heart.fill", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(image: "person.circle.fill", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, edges?.bottom ?? 15)
                .background(scheme == .dark ? .black : .white)
            }
            , alignment: .bottom
        )
        .ignoresSafeArea()
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
            selectedTab = image
        }, label: {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(selectedTab == image ? .primary : .gray)
        })
    }
}
