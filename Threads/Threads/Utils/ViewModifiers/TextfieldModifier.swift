//
//  TextfieldModifier.swift
//  Threads
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI

struct TextfieldModifier: ViewModifier {
   
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray6))
            }
            .padding(.horizontal)
    }
}
