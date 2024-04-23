//
//  StoryViewModel.swift
//  InstagramStory
//
//  Created by Nap Works on 24/02/24.
//

import SwiftUI

class StoryViewModel: ObservableObject {
    @Published var stories: [StoryBundle] = [
     StoryBundle(profileName: "iJustine", profileImage: "pic1", stories: [
       Story(imageURL: "post1"),
       Story(imageURL: "post2"),
       Story(imageURL: "post3")
     ]),
     
     StoryBundle(profileName: "Jenna Ezarik", profileImage: "pic2", stories: [
       Story(imageURL: "post4"),
       Story(imageURL: "post5")
     ]),
     
    ]
    
    @Published var showStory: Bool = false
    @Published var currentStory: String = ""
    
    
}
