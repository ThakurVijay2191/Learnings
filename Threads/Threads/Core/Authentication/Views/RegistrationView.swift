//
//  RegistrationView.swift
//  Threads
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel: RegistrationViewModel = .init()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image("threads")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email", text: $viewModel.email)
                    .textInputAutocapitalization(.none)
                    .modifier(TextfieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(TextfieldModifier())
                
                TextField("Enter your fullname", text: $viewModel.fullname)
                    .modifier(TextfieldModifier())
                
                TextField("Enter your username", text: $viewModel.username)
                    .modifier(TextfieldModifier())
            }
        
            Button(action: {
                Task { try await viewModel.createUser() }
            }, label: {
                Text("Sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.black)
                    }
                    .padding()
            })
            
            Spacer()
            
            Divider()
            
            Button {
               dismiss()
            } label: {
                (
                  Text("Already have an account? ")
                  
                  +
                  
                  Text("Sign in")
                    .fontWeight(.semibold)
                )
                .font(.footnote)
                .foregroundStyle(.black)
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
