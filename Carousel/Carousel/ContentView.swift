//
//  ContentView.swift
//  Carousel
//
//  Created by Nap Works on 08/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [Item] = [
        .init(color: .red, title: "World Clock", subTitle: "View the time in multiple cities around the world."),
//        .init(color: .blue, title: "City Digital", subTitle: "Add a clock for a city to check the time at that location."),
//        .init(color: .green, title: "City Analouge", subTitle: "Add a clock for a city to check the time at that location."),
//        .init(color: .yellow, title: "Next Alarm", subTitle: "Display upcoming alarm.")
    ]
    var body: some View {
        CustomPagingSlider(data: $items) { $item in
            RoundedRectangle(cornerRadius: 15)
                .fill(item.color.gradient)
        }
        .safeAreaPadding([.horizontal, .top], items.count == 1 ? 20 : 30)

    }
}

#Preview {
    ContentView()
}

struct ColorModel: Identifiable{
    var id: String = UUID().uuidString
    var color: Color
}
