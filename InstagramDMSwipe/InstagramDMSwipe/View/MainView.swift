//
//  MainView.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 17/09/23.
//

import SwiftUI

struct MainView: View {
    @State var offset: CGFloat = rect.width
    
    var body: some View {
       
        GeometryReader{ reader in
            let frame = reader.frame(in: .global)
            ScrollableTabBar(tabs: ["", "", ""], rect: frame, offset: $offset) {
                PostView(offset: $offset)
                Home(offset: $offset)
                DirectView(offset: $offset)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
