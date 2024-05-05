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
