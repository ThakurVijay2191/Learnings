//
//  CustomPagingSlider.swift
//  Carousel
//
//  Created by Nap Works on 10/03/24.
//

import SwiftUI

struct Item: Identifiable {
    private(set) var id: UUID = .init()
    var color: Color
    var title: String
    var subTitle: String
    
}

struct CustomPagingSlider<Content: View,Item: RandomAccessCollection>: View where Item: MutableCollection , Item.Element: Identifiable{
    var showsIndicator: ScrollIndicatorVisibility = .hidden
    var showPagingControl: Bool = true
    var pagingControlSpacing: CGFloat = 20
    var spacing: CGFloat = 10
    @Binding var data: Item
    @ViewBuilder var content: (Binding<Item.Element>)->Content
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: spacing){
                ForEach($data){ item in
                    VStack (spacing: 0){
                        content(item)
                    }
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(showsIndicator)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview(body: {
    ContentView()
})
