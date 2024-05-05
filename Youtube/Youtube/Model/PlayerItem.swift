//
//  PlayerItem.swift
//  Youtube
//
//  Created by Nap Works on 04/05/24.
//

import SwiftUI

let dummyDescription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

struct PlayerItem: Identifiable, Equatable {
    let id: UUID = .init()
    var title: String
    var author: String
    var image: String
    var description: String = dummyDescription
}

var items: [PlayerItem] = [
    .init(title: "SwiftUI DatePicker TextField Input Views | Xcode 15", author: "Kavsoft", image: "Pic 1"),
    .init(title: "SwiftUI Expandable Navigation & Search Bar - iOS 17", author: "Kavsoft", image: "Pic 2"),
    .init(title: "SwiftUI Range Slider | Xcode 15", author: "Kavsoft", image: "Pic 3"),
    .init(title: "SwiftData Value Transformers With Transformable", author: "Kavsoft", image: "Pic 4"),
    .init(title: "SwiftUI Scrollable Tab Bar - iOS 17", author: "Kavsoft", image: "Pic 5"),
]
