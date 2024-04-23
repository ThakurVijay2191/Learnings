//
//  CommonMethods.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

class CommonMethods {
    static let LOCAL_TAG = String(describing: CommonMethods.self)
    static func showLog(_ tag: String, _ message: String){
        print("TEST \(tag) \(message)")
    }
    
    static func logout() {
        showLog(LOCAL_TAG, "logout")
        UserDefaultsMapper.removeCurrentUserData()
    }
}
