//
//  Tab.swift
//  Youtube
//
//  Created by Nap Works on 04/05/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case shorts = "Shorts"
    case subscriptions = "Subscriptions"
    case you = "You"
    
    var symbol: String {
        switch self {
        case .home:
            return "house.fill"
        case .shorts:
            return "video.badge.waveform.fill"
        case .subscriptions:
            return "play.square.stack.fill"
        case .you:
            return "person.circle.fill"
        }
    }
}
