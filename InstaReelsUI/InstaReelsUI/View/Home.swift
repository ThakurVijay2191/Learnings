//
//  Home.swift
//  InstaReelsUI
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI

struct Home: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State private var currentTab: String = "Reels"
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                ReelsView()
                    .tag("Reels")
                
                Text("Liked")
                    .tag("suit.heart")
                
                Text("Profile")
                    .tag("person.circle")
            }
            
            HStack (spacing: 0){
                ForEach(["house.fill", "magnifyingglass", "Reels", "suit.heart", "person.circle"], id: \.self){ image in
                    TabBarButton(image: image, isSystemImage: image != "Reels", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    Home()
}

struct TabBarButton: View {
    var image: String
    var isSystemImage: Bool
    @Binding var currentTab: String
    var body: some View {
        Button(action: {
            withAnimation {
                currentTab = image
            }
        }, label: {
            ZStack {
                if isSystemImage {
                    Image(systemName: image)
                        .font(.title2)
                }else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
            .foregroundStyle(currentTab == image ? Color(.label) : .gray)
            .frame(maxWidth: .infinity)
        })
    }
}
