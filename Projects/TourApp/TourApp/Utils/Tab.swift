//
//  Tab.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case explore = "Explore"
    case map = "Map"
    case myTour = "My Tour"
    case profile = "Profile"
    
    var image: String{
        switch self {
        case .explore:
            return "pin_icon"
        case .map:
            return "map_icon"
        case .myTour:
            return "heart_icon"
        case .profile:
            return "user_icon"
        }
    }

}
