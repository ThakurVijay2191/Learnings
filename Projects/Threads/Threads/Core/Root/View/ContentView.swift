//
//  ContentView.swift
//  Threads
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = .init()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabBarView()
            }else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
