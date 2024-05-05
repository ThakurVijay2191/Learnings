//
//  HomeView.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreView: View {
    @StateObject private var viewModel: ExploreViewModel = .init()
    @State private var searchText: String = ""
    var body: some View {
        GeometryReader{ reader in
            VStack {
                HeaderView()
                if viewModel.showIndicator {
                    ProgressView()
                        .tint(.orangeText)
                        .scaleEffect(3)
                        .vSpacing()
                }else {
                    if viewModel.cards.count > 0 {
                        CarouselView(reader.size)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
//            .frame(width: reader.size.width, height: reader.size.height)
            .background(.darkBackground)

        }
        .ignoresSafeArea(.keyboard, edges: .bottom)

    }
    
    @ViewBuilder
    func HeaderView()-> some View {
        VStack {
            Text("myTour")
                .font(.lobster(.regular, size: 30))
                .foregroundStyle(.white)
            
            HStack {
                TextField("", text: $searchText)
                    .font(.montserrat(.regular, size: 16))
                    .foregroundStyle(.black)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Search full width")
                            .font(.montserrat(.regular, size: 16))
                            .foregroundStyle(.black)
                    }
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(.white, in: .capsule)
            
            VStack (alignment: .leading, spacing: 4){
                Text(attributedString)
                    .font(.montserrat(.semibold, size: 20))
                    .foregroundStyle(.white)
                
                Text("Fantastic sights close to you")
                    .font(.montserrat(.regular, size: 14))
                    .foregroundStyle(.white)
            }
            .hSpacing(.leading)
            .padding(.vertical, 12)
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func CarouselView(_ size: CGSize)->some View {
        ScrollView(.horizontal) {
            HStack (spacing: 10){
                ForEach(viewModel.cards){ card in
                    CardView(card, size: size)
                 }
            }
            .padding(.horizontal, 30)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .padding(.horizontal, -15)
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func CardView(_ card: CardDataModel, size: CGSize)-> some View {
        VStack {
            Rectangle()
                .fill(.clear)
                .overlay {
                    WebImage(url: URL(string: card.thumbnail ?? ""), options: [.waitStoreCache])
                        .resizable()
                    .aspectRatio(contentMode: .fill)
                }
                .overlay {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [
                            .clear,
                            .clear,
                            .black.opacity(0.8),
                            .black.opacity(0.9),
                        ], startPoint: .top, endPoint: .bottom)
                        
                        VStack (alignment: .leading, spacing: 12){
                            Text(card.title ?? "")
                                .font(.montserrat(.semibold, size: 20))
                                .foregroundStyle(.white)
                            
                            Text(card.description ?? "")
                                .font(.montserrat(.regular, size: 16))
                                .foregroundStyle(.white)
                            
                            Text(card.brand ?? "")
                                .font(.montserrat(.medium, size: 16))
                                .foregroundStyle(.orangeText)
                                .hSpacing(.trailing)
                         
                        }
                        .hSpacing(.leading)
                        .padding(15)
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                            .padding([.top, .trailing], 15)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 1)
                    }
                    .buttonStyle(StaticButtonStyle())

                }
           
        }
        .frame(width: size.width - 60)
        .clipShape(.rect(cornerRadius: 15))
        .padding(.bottom, 20)
        .shadow(color: .white.opacity(0.1), radius: 5, x: 2, y: 2)
        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
            view
                .scaleEffect(phase.isIdentity ? 1 : 0.95)
        }
            
            
    }
    
    var attributedString: AttributedString {
        var attributedString = AttributedString("Spots to explore")
        guard let range = attributedString.range(of: "Spots") else {return ""}
        attributedString[range].foregroundColor = .orangeText
        
        return attributedString
    }
}

#Preview {
    MainView()
}
