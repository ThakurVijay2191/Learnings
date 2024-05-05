//
//  LoginView.swift
//  SocialMediaApp
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var createAccount: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            Text("Let's Sign you in")
                .font(.largeTitle.bold())
                .hAlign(.leading)
             Text("Welcome Back,\nYou have been missed")
                .font(.title3)
                .hAlign(.leading)
            
            VStack (spacing: 12){
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .border(1, .gray.opacity(0.5))
                
                Button("Reset password?", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(Color(.label))
                    .hAlign(.trailing)
                
                Button(action: loginUser, label: {
                    Text("Sign in")
                        .foregroundStyle(Color(.systemBackground))
                        .hAlign(.center)
                        .fillView(Color(.label))
                })
                .padding(.top, 10)
                
            }
            
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("Register Now") {
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundStyle(Color(.label))
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .fullScreenCover(isPresented: $createAccount, content: {
            RegisterView()
        })
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    private func loginUser(){
        Task {
            do{
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("User found")
            }catch let error as AuthErrorCode{
                
                await setError(error)
            }
        }
    }
    
    private func resetPassword(){
        Task {
            do{
                try await Auth.auth().sendPasswordReset(withEmail: email)
                print("Password Link Sent")
            }catch let error{
                await setError(error)
            }
        }
    }
    
    private func setError(_ error: Error) async{
        await MainActor.run {
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }
}

#Preview {
    LoginView()
}

//View Extensions
extension View {
    func hAlign(_ alignment: Alignment) ->some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) ->some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func border(_ width: CGFloat, _ color: Color)-> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    func fillView(_ color: Color)-> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
}
