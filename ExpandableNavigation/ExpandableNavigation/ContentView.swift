//
//  ContentView.swift
//  ExpandableNavigation
//
//  Created by Nap Works on 28/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
