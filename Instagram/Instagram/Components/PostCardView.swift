//
//  PostCardView.swift
//  Instagram
//
//  Created by Nap Works on 17/03/24.
//

import SwiftUI

struct PostCardView: View {
    @Environment(\.colorScheme) private var scheme
    @Binding var homeStack: [HomeNavigation]
    var size: CGSize
    var body: some View {
        VStack {
            HStack(spacing: 10){
                Button(action: {
                    homeStack.append(.profile)
                }, label: {
                    Image("sajal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(.circle)
                })
                
                HStack (spacing: 5){
                    Text("pyaari_sajal")
                        .font(.system(size: 16, weight: .medium))
                        
                    Image("blue_tick")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                }
                .hSpacing(.leading)
                
                Image("dot_horizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25)
            }
            .padding(.horizontal)
            
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width)
            
            HStack {
                HStack(spacing: 20){
                    Image("heart")
                        .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
                    
                    Image("comment")
                        .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
                    
                    Image("send")
                        .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
                    
                }
                .hSpacing(.leading)
                
                Image("bookmark")
                    .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
            }
            .padding(.horizontal)
            .padding(.top, 2)
            .padding(.bottom, 4)
            
            HStack (spacing: 4){
                HStack (spacing: -10){
                    ForEach((1...3).reversed(), id: \.self){ index in
                      Image("sajal")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 18, height: 18)
                            .clipShape(.circle)
                            .padding(2)
                            .background(scheme == .dark ? .black : .white, in: .circle)
                            .zIndex(Double(index))
                    }
                }
                
                (
                    Text("Liked by ")
                        .fontWeight(.regular)
                    +
                    Text("sajalkideewani")
                        .fontWeight(.semibold)
                    +
                    Text(" and ")
                        .fontWeight(.regular)
                    +
                    Text("117,037 others")
                        .fontWeight(.semibold)
                )
                .font(.system(size: 14))
                .hSpacing(.leading)
            }
            .padding(.horizontal)
            
            VStack(spacing: 5){
                Text("View all 778 comments")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .hSpacing(.leading)
                    .padding(.horizontal)
                
                
                Text("5 days ago")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .hSpacing(.leading)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}

