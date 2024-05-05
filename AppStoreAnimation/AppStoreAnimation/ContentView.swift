//
//  ContentView.swift
//  AppStoreAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI
import VTFrameworks

struct ContentView: View {
    var body: some View {
       Home()
            .onAppear {
                Validator.sayHello()
            }
    }
}

#Preview {
    ContentView()
}
