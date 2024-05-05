//
//  Home.swift
//  Instagram
//
//  Created by Nap Works on 02/03/24.
//

import SwiftUI

struct Home: View {
    @State private var number: Double = 0
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var homeStack: [HomeNavigation] = []
    @Binding var offset: CGFloat
    var body: some View {
        GeometryReader{
            let screenSize = $0.size
            
            NavigationStack(path: $homeStack){
                VStack(spacing: 0){
                    HeaderView()
                        .padding(.top, edges?.top)
                    ScrollView {
                        VStack(spacing: 0){
                            StoriesView()
                            Divider()
                                .padding(.top, 4)
                                .padding(.bottom, 10)
                            
                            LazyVStack(spacing: 15){
                                ForEach(1...10, id: \.self){ _ in
                                    PostCardView(homeStack: $homeStack, size: screenSize)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
//                .navigationDestination(for: HomeNavigation.self) { value in
//                    switch value {
//                    case .profile:
//                        EditProfile()
//                    }
//                }
            }
        }
    }
    
    //MARK: - Header View
    @ViewBuilder
    func HeaderView()->some View {
        HStack {
            Button(action: {}, label: {
                HStack {
                    Image("logo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 35)
                    
                    Image("chevron")
                        .IconModifier(size: .init(width: 18, height: 18), renderingMode: .template)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .rotationEffect(.init(degrees: 180))
                }
            })
            .hSpacing(.leading)
            .padding(.bottom, 6)
            
            HStack(spacing: 25){
                Button(action: {
                }, label: {
                    Image("heart")
                        .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)

                })
                
                Button(action: {
                    offset = rect.width * 2
                }, label: {
                    Image("message")
                        .IconModifier(size: .init(width: 25, height: 25), renderingMode: .template)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .overlay(alignment: .topTrailing) {
                            ZStack {
                                Text("1")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                            }
                            .frame(width: 16, height: 16)
                            .background(.igRed, in: .circle)
                            .offset(x: 5, y: -5)
                        }
                })
            }
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
    
    //MARK: - Stories View
    @ViewBuilder
    func StoriesView()->some View {
        ScrollView(.horizontal) {
            HStack (alignment: .top, spacing: 8){
                CreateStoryBoxView()
                HStack (spacing: 4){
                    ForEach(1...10, id: \.self){ _ in
                        StoryBoxView()
                    }
                }
                
            }
            .padding(.vertical, 4)
        }
        .safeAreaPadding(.horizontal)
        .scrollIndicators(.hidden)

    }
    
    @ViewBuilder
    func CreateStoryBoxView()->some View {
        VStack {
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .clipShape(.circle)
                .overlay(alignment: .bottomTrailing){
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .padding(2)
                        .background(colorScheme == .dark ? .black : .white, in: .circle)
                        .offset(x: 4, y: 4)
                }
                .padding(2)
                .background(colorScheme == .dark ? .black : .white, in: .circle)
                .padding(2)
               
            
            Text("Your story")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
                .lineLimit(1)
        }
        .frame(maxWidth: 85)
    }
    
    @ViewBuilder
    func StoryBoxView()->some View {
        VStack {
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .clipShape(.circle)
                .padding(2)
                .background(colorScheme == .dark ? .black : .white, in: .circle)
                .padding(2)
                .background {
                    LinearGradient.init(
                        colors: [
                            .red,
                            .orange,
                            .red,
                            .orange
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(.circle)
                }
            
            Text("pyaari_sajal")
                .font(.caption)
                .foregroundStyle(.primary)
                .fontWeight(.light)
                .lineLimit(1)
        }
        .frame(width: 95)
    }

}

#Preview {
    MainTabView()
}
