//
//  ContentView.swift
//  Biometric
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LockView(lockType: .both, lockPin: "0320", isEnabled: true) {
            VStack(spacing: 15){
                Image(systemName: "globe")
                    .imageScale(.large)
                Text("Hello World")
            }
        }
    }
}

#Preview {
    ContentView()
}
