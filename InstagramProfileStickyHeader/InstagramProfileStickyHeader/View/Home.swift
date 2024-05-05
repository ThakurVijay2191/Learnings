//
//  Home.swift
//  InstagramProfileStickyHeader
//
//  Created by Nap Works on 16/09/23.
//

import SwiftUI

struct Home: View {
    @State var selectedTab: String = "square.grid.3x3"
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    @State var topHeaderOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Text("_sajalAly")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "plus.app")
                        .font(.title)
                        .foregroundColor(.primary)
                })

                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.primary)
                })
            }
            .padding([.horizontal, .top])
            .overlay (
                GeometryReader(content: { proxy->Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        if topHeaderOffset == 0 {
                            topHeaderOffset = minY
                        }
                    }
                    return Color.clear
                })
                .frame(width: 0, height: 0)
                , alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    Divider()
                    
                    HStack {
                        Button(action: {}, label: {
                            Image("post1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay (
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .padding(2)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .offset(x: 5, y: 5)
                                    ,
                                    alignment: .bottomTrailing
                                )
                        })
                        VStack {
                            Text("199")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            
                            Text("Posts")
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("1,235")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            
                            Text("Followers")
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("1M")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            
                            Text("Following")
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Sajal Aly")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text("Actress")
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                        
                        Text("I am Sajal Aly and very happy to see that my fans loves me so much and I love them also.. and they motivates me to do my best in pakistani dramas..")
                        Link(destination: URL(string: "https://www.instagram.com/sajalaly/")!) {
                            Text("Profile Link")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    HStack(spacing: 10){
                        Button(action: {}, label: {
                            Text("Edit Profile")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray)
                                }
                            
                        })
                        
                        Button(action: {}, label: {
                            Text("Promotion's")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray)
                                }
                            
                        })
                    }
                    .padding([.horizontal, .top])
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.primary)
                                        .padding(18)
                                        .background(Circle().stroke(Color.gray))
                                    
                                    Text("New")
                                        .foregroundColor(.primary)
                                }
                            })
                        }
                        .padding([.horizontal, .top])
                    }
                    
                    GeometryReader{ proxy-> AnyView in
                        let minY = proxy.frame(in: .global).minY
                        let offset = minY - topHeaderOffset
                        return AnyView(
                            HStack(spacing: 0){
                                TabBarButton(image: "square.grid.3x3", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
                                TabBarButton(image: "reels", isSystemImage: false, animation: animation, selectedTab: $selectedTab)
                                TabBarButton(image: "person.crop.square", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
                            }
                            .frame(height: 70, alignment: .bottom)
                            .background(scheme == .dark ? .black : .white)
                            .offset(y: offset < 0 ? -offset : 0)
                            
                        )
                    }
                    .frame(height: 70)
                    .zIndex(4)
                    
                    ZStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3), spacing: 2, content: {
    
                            ForEach(1...30, id: \.self) { id in
                                GeometryReader { proxy in
                                    let width = proxy.frame(in: .global).width
                                    ImageView(index: id, width: width)
                                }
                                .frame(height: 120)
                            }
                        })
                    }
                }
                
            }
        }
    }
}

#Preview {
    Home()
}


struct ImageView: View {
    var index: Int
    var width: CGFloat
    
    var body: some View {
        let imageName = index > 10 ? index - (10 * (index / 10)) == 0 ? 10 : index - (10 * (index / 10)) : index
        VStack {
            Image("post\(imageName)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: 120)
                .clipped()
        }
    }
}

struct TabBarButton: View {
    var image: String
    var isSystemImage: Bool
    var animation: Namespace.ID
    @Binding var selectedTab: String
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                selectedTab = image
            }
        } label: {
            VStack(spacing: 12, content: {
                (
                    isSystemImage ? Image(systemName: image) : Image(image)
                )
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(selectedTab == image ? .primary : .gray)
                
                ZStack {
                    if selectedTab == image {
                        Rectangle()
                            .fill(Color.primary)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }else {
                        Rectangle()
                            .fill(Color.clear)
                    }
                    
                }
                .frame(height: 1)
            })
        }

    }
}
