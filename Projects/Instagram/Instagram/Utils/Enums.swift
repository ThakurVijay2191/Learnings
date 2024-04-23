//
//  Enums.swift
//  Instagram
//
//  Created by Nap Works on 07/01/24.
//

import SwiftUI

enum Tab: CaseIterable {
    case home
    case search
    case createPost
    case reels
    case account
    
    var inActiveImage: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "search"
        case .createPost:
            return "plus"
        case .reels:
            return "reel"
        case .account:
            return "sajal"
        }
    }
    
    var activeImage: String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "search.fill"
        case .createPost:
            return "plus"
        case .reels:
            return "reel.fill"
        case .account:
            return "sajal"
        }
    }
   
}

enum HomeNavigation: String, Hashable {
    case profile = "profile"
}

enum ProfileNavigation: String, Hashable {
    case professionalDashboard = "profile"
}

enum MainNavigation: String, Hashable {
    case editProfile = "edit_profile"
}
