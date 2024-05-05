//
//  Like.swift
//  ReelsLayout
//
//  Created by Nap Works on 06/01/24.
//

import SwiftUI

struct Like: Identifiable {
    var id: UUID = .init()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}
