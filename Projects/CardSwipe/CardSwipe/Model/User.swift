//
//  User.swift
//  CardSwipe
//
//  Created by Nap Works on 11/11/23.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}
