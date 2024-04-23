//
//  Loader.swift
//  TourApp
//
//  Created by Nap Works on 19/04/24.
//

import SwiftUI

struct Loader: View {
    @State private var animate: Bool = false
    var body: some View {
        GeometryReader {reader in
            VStack {
                Circle()
                    .stroke(.linearGradient(colors: [
                        Color.white,
                        Color.white,
                        Color.white,
                        Color.white,
                        Color.white.opacity(0.7),
                        Color.white.opacity(0.4),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.0)
                    ], startPoint: .top, endPoint: .bottom), lineWidth: 4.0)
                    .rotationEffect(.init(degrees: animate ? 360 : 0))
                    .onAppear {
                        withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                            animate = true
                        }
                    }
                    .frame(width: 100, height: 100)
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(.black.opacity(0.4))
            .onAppear(perform: {
                self.animate.toggle()
            })
        }
    }
}

#Preview {
    Loader()
}
