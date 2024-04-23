//
//  MainTabView.swift
//  Instagram
//
//  Created by Nap Works on 24/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainTabView: View {
    @State var offset: CGFloat = rect.width
    @State private var homeCurrentTab: TabModel = .init(inActiveImage: "house", activeImage: "house.fill", type: .home)
    @State private var scrollId: String?
    @State private var currentIndex: Int = 1
    @State private var previousTab: TabModel?
    @State private var isPlusClicked: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        GeometryReader{ reader in
            let frame = reader.frame(in: .global)
            
            ScrollableTabBar(tabs: ["", "", ""], rect: frame, offset: $offset, homeCurrentTab: $homeCurrentTab, isPlusClicked: $isPlusClicked) {
                Color.black
        
                MainView(activeTab: $homeCurrentTab, offset: $offset, isPlusClicked: $isPlusClicked)

                ChatsView(offset: $offset)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .onChange(of: offset) { oldValue, newValue in
            if offset >= rect.width {
                isPlusClicked = false
            }
        }
    }
}

#Preview {
    MainTabView()
}

