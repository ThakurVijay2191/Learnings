//
//  ContentView.swift
//  NetflixAnimation
//
//  Created by Nap Works on 28/04/24.
//

import SwiftUI

struct ContentView: View {
    var appData: AppData = .init()
    var body: some View {
        ZStack {
            if !appData.isSplashFinished {
                SplashScreen()
            }
        }
        .environment(appData)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
