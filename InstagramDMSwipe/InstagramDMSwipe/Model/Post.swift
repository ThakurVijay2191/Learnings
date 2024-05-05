//
//  Post.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 17/09/23.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID().uuidString
    var user: String
    var profile: String
    var postImage: String
    var postTitle: String
    var time: String
    
}

var posts = [
   Post(user: "Sajal Aly", profile: "profile1", postImage: "post1", postTitle: "My New Post", time: "10 min ago"),
   Post(user: "Sajal Aly Fan Page", profile: "profile2", postImage: "post2", postTitle: "My Post by Fan Page", time: "20 min ago"),
   Post(user: "Sajal Ki Diwani", profile: "profile3", postImage: "post3", postTitle: "My New Post", time: "10 min ago"),
   Post(user: "Sajal Aly Page", profile: "profile4", postImage: "post4", postTitle: "My New Post", time: "24 min ago"),
   Post(user: "Sajal Aly New Page", profile: "profile5", postImage: "post5", postTitle: "My New Post", time: "10 min ago"),
]
