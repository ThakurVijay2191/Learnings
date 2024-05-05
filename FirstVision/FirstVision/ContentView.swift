//
//  ContentView.swift
//  FirstVision
//
//  Created by Nap Works on 21/04/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            VStack {
                ForEach(1...10, id: \.self){ _ in
                   Text("Hello")
                }
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
