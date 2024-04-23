//
//  LayerView.swift
//  ReelsLayout
//
//  Created by Nap Works on 17/01/24.
//

import SwiftUI

struct LayerView: View {
    var body: some View {
        VStack {
            LinearGradient(
                colors: [
                    .black.opacity(0.79),
                    .black.opacity(0.69),
                    .black.opacity(0.59),
                    .black.opacity(0.49),
                    .black.opacity(0.39),
                    .black.opacity(0.29),
                    .black.opacity(0.19),
                    .black.opacity(0.13),
                    .black.opacity(0.1),
                    .black.opacity(0.07),
                    .black.opacity(0.03),
                    .black.opacity(0.00)
                ],
                startPoint: .bottom,
                endPoint: .top)
            .frame(height: 120)
        }
    }
}

#Preview {
    LayerView()
}
