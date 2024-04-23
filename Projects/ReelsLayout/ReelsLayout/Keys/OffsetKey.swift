//
//  OffsetKey.swift
//  ReelsLayout
//
//  Created by Nap Works on 06/01/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
