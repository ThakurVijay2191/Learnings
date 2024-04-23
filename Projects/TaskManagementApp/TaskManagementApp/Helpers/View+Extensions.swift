//
//  View+Extensions.swift
//  TaskManagementApp
//
//  Created by Nap Works on 13/11/23.
//

import SwiftUI

extension View {
    
    ///Custom Horizontal Spacing Extension to align the view horizontally
    @ViewBuilder
    func hSpacing(_ alignment: Alignment)-> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    ///Custom Vertical Spacing Extension to align the view vertically
    @ViewBuilder
    func vSpacing(_ alignment: Alignment)-> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
