//
//  Home.swift
//  HeroAnimation
//
//  Created by Nap Works on 09/12/23.
//

import SwiftUI

struct Home: View {
    @State private var pics: [PicItem] = (1...5).compactMap { index-> PicItem? in
        return .init(image: "Pic \(index)")
    }
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15){
                    CardView(pics)
                }
                .safeAreaPadding (15)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Animation")
        }
    }
    
    @ViewBuilder
    func CardView(_ pics: [PicItem])-> some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.teal)
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text("iJustine")
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    Text("Nature Pics ")
                })
                Spacer(minLength: 0)
                
                Button("", systemImage: "ellipsis") {
                    
                }
                .foregroundStyle(.primary)
                .offset(y: -10)
            }
            VStack(alignment: .leading, spacing: 10, content: {
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10, content: {
                            ForEach(pics) { pic in
                                Image(pic.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: size.width)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        })
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                }
                .frame(height: 200)
            })
            .padding(.leading, 45)
          
        }
    }
}

#Preview {
    ContentView()
}
