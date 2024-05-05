//
//  SocialLoginButton.swift
//  TourApp
//
//  Created by Nap Works on 19/04/24.
//

import SwiftUI

struct SocialLoginButton: View {
    var icon: String
    var action: ()->()
    var body: some View {
        Button(action: action, label: {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(.circle)
                .shadow(color: .black.opacity(0.25), radius: 5, x: 1, y: 1)
        })
    }
}

#Preview {
    SocialLoginButton(icon: "") {
        
    }
}
