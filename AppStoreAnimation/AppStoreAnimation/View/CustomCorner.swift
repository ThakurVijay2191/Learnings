//
//  CustomCorner.swift
//  AppStoreAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        return .init(path.cgPath)
    }
}
