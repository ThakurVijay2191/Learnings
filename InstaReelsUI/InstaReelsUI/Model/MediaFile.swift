//
//  MediaFile.swift
//  InstaReelsUI
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
    
}

var MediaFileJSON = [
  MediaFile(url: "Reel1", title: "Sajal Aly...."),
  MediaFile(url: "Reel2", title: "Sajal Aly so beautiful"),
  MediaFile(url: "Reel3", title: "I fall in love with her..."),
  MediaFile(url: "Reel4", title: "She is so damn beautiful.."),
  MediaFile(url: "Reel5", title: "Hii, What's upp fans..."),
  MediaFile(url: "Reel6", title: "It's Sajal Here..."),
]
