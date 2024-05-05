//
//  RectKey.swift
//  DarkModeAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
