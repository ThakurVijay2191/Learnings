//
//  Reel.swift
//  Instagram
//
//  Created by Nap Works on 17/03/24.
//

import SwiftUI

struct ReelMainView: View {
    @State private var reels: [Reel] = reelsData
    @State private var likedCounter: [Like] = []
    @State private var currentId: UUID?
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach($reels) { $reel in
                        ReelView(
                            reel: $reel,
                            likedCounter: $likedCounter,
                            size: size,
                            safeArea: safeArea
                        )
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical)
                        .onAppear {
                            currentId = reel.id
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .background(.black)
            .overlay(alignment: .topLeading, content: {
                ZStack {
                    ForEach(likedCounter) { like in
                        Image(systemName: "suit.heart.fill")
                            .font(.system(size: 75))
                            .foregroundStyle(.red.gradient)
                            .frame(width: 100, height: 100)
                            .animation(.smooth, body: { view in
                                view
                                    .scaleEffect(like.isAnimated ? 1 : 1.8)
                                    .rotationEffect(.init(degrees: like.isAnimated ? 0 : .random(in: -30...30)))
                            })
                            .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
                            .offset(y: like.isAnimated ? -(like.tappedRect.y + safeArea.top + 100) : 0)
                    }
                }
            })
            .overlay(alignment: .top, content: {
                Text("Reels")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button("", systemImage: "camera") {
                            
                        }
                        .font(.title2)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 15)
                    .padding(.top, edges?.top)
                    .padding(.top, 4)
            })
            .environment(\.colorScheme, .dark)
        }   
    }
}

#Preview {
    MainTabView()
}
