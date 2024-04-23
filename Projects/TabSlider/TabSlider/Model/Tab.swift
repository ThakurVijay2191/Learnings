//
//  Tab.swift
//  TabSlider
//
//  Created by Nap Works on 17/02/24.
//

import SwiftUI

struct Tab: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var tabName: String
    var sampleImage: String
}

var sampleTabs: [Tab] = [
    .init(tabName: "Iceland", sampleImage: "Image1"),
    .init(tabName: "France", sampleImage: "Image2"),
    .init(tabName: "Brazil", sampleImage: "Image3")
]
