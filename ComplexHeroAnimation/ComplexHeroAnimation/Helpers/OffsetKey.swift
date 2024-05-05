//
//  OffsetKey.swift
//  ComplexHeroAnimation
//
//  Created by Nap Works on 28/04/24.
//

import SwiftUI

///Anchor Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()){ $1 }
    }
}
