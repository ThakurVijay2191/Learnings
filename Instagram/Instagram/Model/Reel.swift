//
//  Reel.swift
//  ReelsLayout
//
//  Created by Nap Works on 06/01/24.
//

import SwiftUI

struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "Reel1", authorName: "SajalAly"),
    .init(videoID: "Reel2", authorName: "Sajal"),
    .init(videoID: "Reel3", authorName: "Pyari Sajal"),
    .init(videoID: "Reel4", authorName: "Sajal Ki Deewani"),
    .init(videoID: "Reel5", authorName: "Sajal's Addiction")
]

struct ComposModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var isImage: Bool = false
    var image: String = ""
    var reel: String = ""
    var canPlay: Bool = false
}

var composData: [ComposModel] = [
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(reel: "Reel1", canPlay: true),
    .init(reel: "Reel2", canPlay: true),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(reel: "Reel3", canPlay: true),
    .init(reel: "Reel4", canPlay: true),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(isImage: true, image: "sajal"),
    .init(reel: "Reel5", canPlay: true),

]
