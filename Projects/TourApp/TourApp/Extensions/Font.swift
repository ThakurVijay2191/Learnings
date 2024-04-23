//
//  Font.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

extension Font {
    static func montserrat(_ style: Montserrat, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
    
    static func lobster(_ style: Lobster, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}


