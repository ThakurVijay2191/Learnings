//
//  CircularProfileImageView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("image")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
