//
//  ContentView.swift
//  ReelsLayout
//
//  Created by Nap Works on 06/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            Home(size: size, safeArea: safeArea)
                .ignoresSafeArea(.container, edges: .all)
        }
    }
}

#Preview {
    ContentView()
}
