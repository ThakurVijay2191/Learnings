//
//  StackItem.swift
//  CanvasEdit
//
//  Created by Nap Works on 30/03/24.
//

import SwiftUI

struct StackItem: Identifiable {
    var id: String = UUID().uuidString
    var view: AnyView
    
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var scale: CGFloat = 1
    var lastScale: CGFloat = 1
    var rotation: Angle = .zero
    var lastRotation: Angle = .zero
}
