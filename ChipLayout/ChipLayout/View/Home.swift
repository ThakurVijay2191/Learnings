//
//  Home.swift
//  ChipLayout
//
//  Created by Nap Works on 09/03/24.
//

import SwiftUI

struct Home: View {
    @State var text: String = ""
    @State var tags: [Tag] = []
    @State private var currentIndex: Int = 0
    var body: some View {
        GeometryReader { reader in
            TagView(totalWidth: reader.size.width - 40, index: $currentIndex, items: $tags) { $tag in
                RowView(tag: $tag, fontSize: 16)
            }
             
        }
        .padding(.horizontal, 20)
        .onAppear {
            let tag1 = Tag(text: "Guitar")
            let tag2 = Tag(text: "Guitar sample")
            let tag3 = Tag(text: "Guitar")
            let tag4 = Tag(text: "Guitar sa")
            let tag5 = Tag(text: "Guitar sam")
            let tag6 = Tag(text: "Guitar samp")
            tags.append(tag1)
            tags.append(tag2)
            tags.append(tag3)
            tags.append(tag4)
            tags.append(tag5)
            tags.append(tag6)
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color(.BG)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ContentView()
}
