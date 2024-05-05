//
//  ContentView.swift
//  FlipBookAnimation
//
//  Created by Nap Works on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    ///View Properties
    @State private var progress: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                OpenableBookView(config: .init(progress: progress)) { size in
                    FrontView(size)
                } insideLeft: { size in
                   LeftView(size)
                } insideRight: { size in
                    
                }

            }
            .padding(15)
            .navigationTitle("Book View")
        }
    }
    
    ///Front View
    @ViewBuilder
    func FrontView(_ size: CGSize)-> some View {
        Image(.book1)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
    }
    
    ///Left View
    @ViewBuilder
    func LeftView(_ size: CGSize)-> some View {
        VStack (spacing: 5){
            Image(.author1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
            
            Text("Thakur Vijay")
                .fontWidth(.condensed)
                .fontWeight(.bold)
                .padding(.top, 8)
        }
    }
    
    ///Right View
    @ViewBuilder
    func RightView(_ size: CGSize)-> some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Description")
            
        })
    }
}

///Interactive Book Card View
struct OpenableBookView<Front: View, InsideLeft: View, InsideRight: View>: View {
    var config: Config = .init()
    @ViewBuilder var front: (CGSize)-> Front
    @ViewBuilder var insideLeft: (CGSize)-> InsideLeft
    @ViewBuilder var insideRight: (CGSize)-> InsideRight
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
    
    struct Config {
        var width: CGFloat = 150
        var height: CGFloat = 200
        var progress: CGFloat = 0
    }
}

#Preview {
    ContentView()
}
