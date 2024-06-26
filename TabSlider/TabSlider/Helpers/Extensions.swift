//
//  Extensions.swift
//  TabSlider
//
//  Created by Nap Works on 17/02/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat)->())-> some View {
        self
            .overlay {
                GeometryReader{ proxy in
                    let minX = proxy.frame(in: .global).minX
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: { value in
                            completion(value)
                        })
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}
