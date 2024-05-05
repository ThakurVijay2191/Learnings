//
//  ContentView.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 16/09/23.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
       MainView()
    }
}

#Preview {
    ContentView()
}

var rect = UIScreen.main.bounds
let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
var edges = windowScene?.windows.first?.safeAreaInsets
