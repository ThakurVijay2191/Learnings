//
//  CustomTextField.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct CustomTextField: View {
    var hint: String
    @Binding var text: String
    var isPassword: Bool = false
    
    var body: some View {
        HStack {
            if isPassword {
                SecureField("", text: $text)
                    .font(.montserrat(.medium, size: 16))
                    .foregroundStyle(.black)
                    .textContentType(.password)
                    .placeholder(when: text.isEmpty) {
                        Placeholder()
                    }
                
            }else {
                TextField("", text: $text)
                    .font(.montserrat(.medium, size: 16))
                    .foregroundStyle(.black)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .placeholder(when: text.isEmpty) {
                        Placeholder()
                    }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 14)
        .background(.white, in: .capsule)
        .padding(.horizontal, 20)
        .clipShape(.capsule)
        .shadow(color: .black.opacity(0.15), radius: 15, x: 1, y: 1)
    }
    
    @ViewBuilder
    func Placeholder()-> some View {
        Text(hint)
            .font(.montserrat(.medium, size: 16))
            .foregroundStyle(.gray)
    }
}

#Preview {
    CustomTextField(hint: "Enter Email", text: .constant(""), isPassword: false)
}
