//
//  Framework.swift
//  AppleFrameworks
//
//  Created by Nap Works on 15/11/23.
//

import SwiftUI

struct Framework {
    let name: String
    let imageName: String
    let urlString: String
    let description: String
}

struct MockData {
    static let frameworks = [
        Framework(name: "App Clips", imageName: "app-clips", urlString: "https://developer.apple.com/app-clips/", description: "")
    ]
}
