//
//  Post.swift
//  ComplexHeroAnimation
//
//  Created by Nap Works on 28/04/24.
//

import SwiftUI

struct Post: Identifiable {
    let id: UUID = .init()
    var username: String
    var content: String
    var pics: [PicItem]
    var scrollPosition: UUID?
}

///Sample Posts
var samplePosts: [Post] = [
    .init(username: "iJustine", content: "Nature Pics", pics: pics),
    .init(username: "iJustine", content: "Nature Pics", pics: pics1)
]

///Constructing Pic using asset images
 private var pics: [PicItem] = (1...5).compactMap { index-> PicItem? in
    return .init(image: "Pic \(index)")
}

///Constructing Pic using asset images
private var pics1: [PicItem] = (1...5).reversed().compactMap { index-> PicItem? in
    return .init(image: "Pic \(index)")
}
