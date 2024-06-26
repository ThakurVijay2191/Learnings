//
//  Home.swift
//  PagingIndicatorAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI

struct Home: View {
    ///view properties
    @State private var colors: [Color] = [.red, .blue, .green, .yellow]
    @State private var opacityEffect: Bool = false
    @State private var clipEdges: Bool = false
    
    var body: some View {
        VStack {
            ///paging view
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(colors, id: \.self){ color in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(color.gradient)
                            .padding(.horizontal, 5)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
                .overlay(alignment: .bottom) {
                    PagingIndicator(
                        activeTint: .white,
                        inactiveTint: .black.opacity(0.25),
                        opacityEffect: opacityEffect,
                        clipEdges: clipEdges
                    )
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .frame(height: 220)
            .safeAreaPadding(.vertical, 15)
            .safeAreaPadding(.horizontal, 25)
            
            List {
                Section("Options") {
                    Toggle("Opacity Effect", isOn: $opacityEffect)
                    Toggle("Clip Edges", isOn: $clipEdges)
                    
                    Button("Add Item") {
                        colors.append(.purple)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 15))
            .padding(15)
        }
        .preferredColorScheme(.light)
        .navigationTitle("CustomIndicator")
    }
}

#Preview {
    ContentView()
}
