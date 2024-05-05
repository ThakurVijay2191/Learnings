//
//  Reel.swift
//  InstaReelsUI
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
