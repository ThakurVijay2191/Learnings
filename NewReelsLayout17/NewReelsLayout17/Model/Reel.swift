//
//  Reel.swift
//  NewReelsLayout17
//
//  Created by Nap Works on 18/11/23.
//

import SwiftUI

struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "Reel1", authorName: "Sajal"),
    .init(videoID: "Reel2", authorName: "Sajal"),
    .init(videoID: "Reel3", authorName: "Sajal"),
    .init(videoID: "Reel4", authorName: "Sajal"),
    .init(videoID: "Reel5", authorName: "Sajal"),
]
