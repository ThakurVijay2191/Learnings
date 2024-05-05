//
//  SnapCarousel.swift
//  Alfaclef
//
//  Created by Nap Works on 07/02/24.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (Binding<T>)-> Content
    @Binding var list: [T]
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var proxy: GeometryProxy
    
    @Binding var index: Int
    init(proxy: GeometryProxy,spacing: CGFloat = 15, trailingSpace: CGFloat = 45, index: Binding<Int>, items: Binding<[T]>, @ViewBuilder content: @escaping (Binding<T>)->Content) {
        self._list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.proxy = proxy
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    
    var body: some View {
        let width = proxy.size.width - (trailingSpace - spacing)
        let adjustmentWidth = (trailingSpace/2)-spacing
        HStack(spacing: spacing){
            ForEach($list){ $item in
                content($item)
                    .frame(width: proxy.size.width - trailingSpace)
            }
        }
        .animation(.easeInOut, value: offset == 0)
        .padding(.horizontal, spacing)
        .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
        .gesture(
          DragGesture()
            .updating($offset, body: { value, out, _ in
                out = value.translation.width
            })
            .onEnded({ value in
                let offsetX = value.translation.width
                let progress = -offsetX / width
                let roundedIndex = progress.rounded()
                currentIndex = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
                
                currentIndex = index
            })
            .onChanged({ value in
                let offsetX = value.translation.width
                let progress = -offsetX / width
                let roundedIndex = progress.rounded()
                index = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
            })
        )

    }
}
//
//#Preview {
//    SliderView1()
//}

