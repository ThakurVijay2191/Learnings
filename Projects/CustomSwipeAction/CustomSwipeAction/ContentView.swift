//
//  ContentView.swift
//  CustomSwipeAction
//
//  Created by Nap Works on 31/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Messages")
        }
    }
}

#Preview {
    ContentView()
}
