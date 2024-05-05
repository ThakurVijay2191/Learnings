//
//  HomeViewModel.swift
//  CardSwipe
//
//  Created by Nap Works on 11/11/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var fetched_users: [User] = []
    
    @Published var displaying_users: [User]?
    
    init() {
      fetched_users = [
        User(name: "Natalia", place: "Vadalia NYC", profilePic: "User1"),
        User(name: "Elisa", place: "Central Park NYC", profilePic: "User2"),
        User(name: "Jasmine", place: "Metropolitan Museum NYC", profilePic: "User3"),
        User(name: "Zahra", place: "Liberty NYC", profilePic: "User4"),
        User(name: "Angelina", place: "Empire State NYC", profilePic: "User5"),
        User(name: "Brittany", place: "Time Square NYC", profilePic: "User6")
      ]
        
      displaying_users = fetched_users
    }
    
    //retreiving index
    func getIndex(user: User)->Int{
        let index = displaying_users?.firstIndex(where: { currentUser in
            return user.id == currentUser.id
        }) ?? 0
        
        return index
    }
    
}
