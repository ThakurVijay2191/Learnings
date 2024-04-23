//
//  LoginScreen.swift
//  Instagram
//
//  Created by Nap Works on 23/03/24.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.red)
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            
            IGBlueButton(title: "Login") {
                
            }
        }
    }
}

struct IGBlueButton: View {
    var title: String
    var action: ()->()
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .hSpacing()
                .background(.blue, in: .rect(cornerRadius: 10))
                .padding(.horizontal, 20)
        })
          
    }
}

#Preview {
    LoginScreen()
}
