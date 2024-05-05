//
//  Home.swift
//  AppleWatchStoreUI
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct Home: View {
    @State private var index = "ALL"
    @State private var tab: Int = 0
    var bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom
    var body: some View {
        ZStack {
            Color.black.opacity(0.06).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                    })
                }
                .padding(.vertical)
                
                HStack {
                    VStack (alignment: .leading, spacing: 10){
                        Text("Welcome!")
                        Text("Discovery")
                            .font(.title.bold())
                    }
                    .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.black)
                    })
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(menu, id: \.self) { title in
                            Button {
                                self.index = title
                            } label: {
                                Text(title)
                                    .foregroundStyle(self.index == title ? Color("Color1") : Color.black.opacity(0.6))
                                    .fontWeight(.bold)
                            }

                        }
                    }
                    .padding(.horizontal)
                }
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 25, content: {
                        ForEach(data, id:\.self) { data in
                            ZStack (alignment: .bottom){
                                Color("Color")
                                    .frame(height: UIScreen.main.bounds.height / 3)
                                    .cornerRadius(20)
                                VStack(spacing: 20) {
                                    Image(data.image)
                                        .resizable()
                                    .frame(width: UIScreen.main.bounds.width / 1.7)
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 12, content: {
                                            Text(data.title)
                                            Text("Apple Watch")
                                                .fontWeight(.bold)
                                                .font(.title)
                                        })
                                        .foregroundStyle(.white)
                                        
                                        Spacer()
                                        
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "plus")
                                                .font(.title)
                                                .foregroundStyle(.white)
                                                .padding()
                                                .background(Color("Color1"))
                                                .clipShape(Circle())
                                        }

                                    }
                            
                                    
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                    })
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                })
                
                HStack {
                    Button {
                        self.tab = 0
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundStyle(self.tab == 0 ? .black : Color.black.opacity(0.25))
                    }
                    
                    Spacer()
                    
                    Button {
                        self.tab = 1
                    } label: {
                        Image(systemName: "safari")
                            .foregroundStyle(self.tab == 1 ? .black : Color.black.opacity(0.25))
                    }
                    
                    Spacer()
                    
                    Button {
                        self.tab = 2
                    } label: {
                        Image(systemName: "person.circle")
                            .foregroundStyle(self.tab == 2 ? .black : Color.black.opacity(0.25))
                    }

                }
                .font(.title)
                .padding(.horizontal, 30)
                .padding(.top, 25)
                .padding(.bottom, self.bottom! == 0 ? 15 : self.bottom! + 10)
                .background(.white)
                .clipShape(CShape())
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    Home()
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

var menu = ["ALL", "CLASSIC", "GRAND", "FORMAL", "ORIGINAL", "TREND"]

struct Watch: Identifiable, Hashable {
    var id: Int
    var color: String
    var price: String
    var image: String
    var title: String
}

var data: [Watch] = [
 Watch(id: 0, color: "Dark Black", price: "$500", image: "black", title: "Classic Black"),
 Watch(id: 0, color: "Light Pink", price: "$300", image: "pink", title: "Classic Pink"),
 Watch(id: 0, color: "White", price: "$400", image: "white", title: "Classic White"),
 Watch(id: 0, color: "Dark Black", price: "$500", image: "black", title: "Classic Black"),
 Watch(id: 0, color: "Light Pink", price: "$300", image: "pink", title: "Classic Pink"),
]
