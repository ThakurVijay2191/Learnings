//
//  StaticButtonStyle.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
