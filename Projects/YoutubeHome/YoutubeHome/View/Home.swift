//
//  Home.swift
//  YoutubeHome
//
//  Created by Nap Works on 03/12/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical) {
            Thumbnails()
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .top) {
            HeaderView()
        }
    }
    
    @ViewBuilder
    func HeaderView()-> some View {
        VStack(spacing: 12){
            VStack(spacing: 0){
                HStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 30)
                    
                    HStack(spacing: 18){
                        ForEach(["Shareplay", "Notifications", "Search"], id: \.self){ icon in
                            Button(action: {}, label: {
                                Image(icon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 23, height: 23)
                                    .foregroundStyle(.black)
                            })
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.bottom, 10)
                
                Divider()
                    .padding(.horizontal, -15)
            }
            .padding([.horizontal, .top], 15)
            
            TagView()
                .padding(.bottom, 10)
        }
        .background {
            Color.white
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TagView()-> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10){
                let Tags = ["All", "iJustine", "Kavsoft", "Apple", "SwiftUI", "Programming", "Technology"]
                ForEach(Tags, id: \.self){ tag in
                    Button(action: {}, label: {
                        Text(tag)
                            .font(.callout)
                            .foregroundStyle(Color.black)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background {
                                Capsule()
                                    .fill(.black.opacity(0.08))
                            }
                    })
                }
            }
            .padding(.horizontal, 15)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func Thumbnails()-> some View {
        VStack(spacing: 20, content: {
            ForEach(0...10, id: \.self) { index in
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    Image("Image\((index % 5) + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                })
                .frame(height: 200)
                .padding(.horizontal)
            }
        })
    }
}

#Preview {
    ContentView()
}
