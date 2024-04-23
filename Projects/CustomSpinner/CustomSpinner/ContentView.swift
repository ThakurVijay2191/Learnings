//
//  ContentView.swift
//  CustomSpinner
//
//  Created by Nap Works on 14/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSpinning: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
            Image(systemName: "applelogo")
                .font(.system(size: 400))
                .blur(radius: 20)

            Circle()
                .stroke(.linearGradient(colors: [
                    .blue,
                    .blue,
                    .blue,
                    .blue,
                    .blue.opacity(0.7),
                    .blue.opacity(0.4),
                    .blue.opacity(0.1),
                    .blue.opacity(0.0)
                ], startPoint: .top, endPoint: .bottom), lineWidth: 4.0)
                .rotationEffect(.init(degrees: isSpinning ? 360 : 0))
                .onAppear {
                    withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                        isSpinning = true
                    }
                }
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    ContentView()
}
