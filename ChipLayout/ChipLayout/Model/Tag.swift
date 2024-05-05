//
//  Tag.swift
//  ChipLayout
//
//  Created by Nap Works on 09/03/24.
//

import SwiftUI

struct Tag: Identifiable, Hashable{
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
    var isSelected: Bool = false
}
