//
//  CustomShape.swift
//  CustomSegmentedPicker
//
//  Created by Nap Works on 02/10/23.
//

import SwiftUI

struct CustomShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
        
    }
    
    
}
