//
//  UserModel.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct UserModel : Codable {
    let lastLogin : Int?
    let userStatus : String?
    let created : Int?
    let accountType : String?
    let socialAccount : String?
    let ownerId : String?
    let oAuthIdentities : String?
    let name : String?
    let ___class : String?
    let blUserLocale : String?
    let user_token : String?
    let updated : String?
    let email : String?
    let objectId : String?

    enum CodingKeys: String, CodingKey {

        case lastLogin = "lastLogin"
        case userStatus = "userStatus"
        case created = "created"
        case accountType = "accountType"
        case socialAccount = "socialAccount"
        case ownerId = "ownerId"
        case oAuthIdentities = "oAuthIdentities"
        case name = "name"
        case ___class = "___class"
        case blUserLocale = "blUserLocale"
        case user_token = "user-token"
        case updated = "updated"
        case email = "email"
        case objectId = "objectId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastLogin = try values.decodeIfPresent(Int.self, forKey: .lastLogin)
        userStatus = try values.decodeIfPresent(String.self, forKey: .userStatus)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        socialAccount = try values.decodeIfPresent(String.self, forKey: .socialAccount)
        ownerId = try values.decodeIfPresent(String.self, forKey: .ownerId)
        oAuthIdentities = try values.decodeIfPresent(String.self, forKey: .oAuthIdentities)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        ___class = try values.decodeIfPresent(String.self, forKey: .___class)
        blUserLocale = try values.decodeIfPresent(String.self, forKey: .blUserLocale)
        user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        objectId = try values.decodeIfPresent(String.self, forKey: .objectId)
    }

}

