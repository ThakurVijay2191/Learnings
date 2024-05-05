//
//  Home.swift
//  CustomSwipeAction
//
//  Created by Nap Works on 31/03/24.
//

import SwiftUI

struct Home: View {
    ///Sample Array of Colors
    @State private var colors: [Color] = [.black, .yellow, .purple, .brown]
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack (spacing: 10){
                ForEach(colors, id: \.self){ color in
                    SwipeAction(cornerRadius: 15, direction: color == .black ? .trailing : .leading) {
                        CardView(color)
                    } actions: {
                        Action(tint: .blue, icon: "star.fill", isEnabled: color == .black) {
                            print("Bookmarked")
                        }
                        Action(tint: .red, icon: "trash.fill") {
                            print("delete")
                            withAnimation(.easeInOut) {
                                colors.removeAll(where: { $0 == color})
                            }
                        }
                    }

                }
            }
            .padding(15)
        }
        .scrollIndicators(.hidden)
    }
    
    ///Sample Card View
    @ViewBuilder
    func CardView(_ color: Color)-> some View {
        HStack (spacing: 12){
            Circle()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 6, content: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 80, height: 5)
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 60, height: 5)
            })
            
            Spacer(minLength: 0)
            
        }
        .foregroundStyle(.white.opacity(0.4))
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(color.gradient)
    }
}
