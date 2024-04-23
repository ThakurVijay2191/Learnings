//
//  StoryBundle.swift
//  InstagramStory
//
//  Created by Nap Works on 24/02/24.
//

import SwiftUI

struct StoryBundle: Identifiable, Hashable{
    var id = UUID().uuidString
    var profileName: String
    var profileImage: String
    var isSeen: Bool = false
    var stories: [Story]
}

struct Story: Identifiable, Hashable{
    var id = UUID().uuidString
    var imageURL: String
    
}
