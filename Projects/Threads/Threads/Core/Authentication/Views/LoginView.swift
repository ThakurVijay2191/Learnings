//
//  LoginView.swift
//  Threads
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("threads")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.none)
                        .modifier(TextfieldModifier())
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(TextfieldModifier())
                }
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button(action: {}, label: {
                    Text("Login")
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
                
                NavigationLink {
                    RegistrationView()
                        .toolbar(.hidden, for: .navigationBar)
                } label: {
                    (
                      Text("Dont' have an account? ")
                      
                      +
                      
                      Text("Sign up")
                        .fontWeight(.semibold)
                    )
                    .font(.footnote)
                    .foregroundStyle(.black)
                    .padding(.vertical, 16)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}


