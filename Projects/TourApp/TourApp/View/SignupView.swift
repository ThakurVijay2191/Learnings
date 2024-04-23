//
//  SignupView.swift
//  TourApp
//
//  Created by Nap Works on 19/04/24.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        GeometryReader{ reader in
            ///Background Image
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: reader.size.width, height: reader.size.height)
            
            LinearGradient(colors: [
                .black.opacity(0.5),
                .clear,
                .black.opacity(0.6)
            ], startPoint: .topTrailing, endPoint: .bottomLeading)
            
            ScrollView(.vertical){
                ///Main Content
                VStack {
                    Spacer()
                   Text("myTour")
                        .font(.lobster(.regular, size: 70))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.35), radius: 2, x: 1, y: 1)
                    ///TextFields
                    VStack (spacing: 15){
                        CustomTextField(hint: "E-mail", text: $viewModel.email)
                        CustomTextField(hint: "Password", text: $viewModel.password, isPassword: true)
                        CustomTextField(hint: "Confirm Password", text: $viewModel.confirmPassword, isPassword: true)
                    }
                    
                    ///Explore Button
                    Button(action: {
                        hapticImpact()
                        viewModel.signupUser()
                    }, label: {
                        HStack {
                            Text("Explore")
                            Image(systemName: "arrow.right")
                        }
                        .font(.montserrat(.semibold, size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.white, in: .capsule)
                        .clipShape(.capsule)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 1, y: 1)
                    })
                    .hSpacing(.trailing)
                    .padding(.trailing, 20)
                    .padding(.top, 12)
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.montserrat(.medium, size: 16))
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Login")
                                .font(.montserrat(.semibold, size: 16))
                        })
                    }
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    VStack (spacing: 16){
                        HStack (spacing: 20){
                            SocialLoginButton(icon:"apple_logo") {
                                hapticImpact()
                            }
                            
                            SocialLoginButton(icon: "facebook_logo") {
                                hapticImpact()
                            }
                            
                            SocialLoginButton(icon: "google_logo") {
                                hapticImpact()
                            }
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Forgot Password?")
                                .font(.montserrat(.semibold, size: 14))
                                .foregroundStyle(.white)
                        })
                    }
                    .padding(.bottom, reader.safeAreaInsets.bottom + 30)
                }
                .frame(height: reader.size.height)
            }
            .scrollIndicators(.hidden)
            .keyboardObserving(offset: 20)
        }
        .overlay(content: {
            if viewModel.showLoader {
                Loader()
            }
        })
        .ignoresSafeArea()
        .alert("Tour App", isPresented: $viewModel.showSignupAlert, actions: {}, message: {
            Text(viewModel.alertMessage)
        })
        .navigationDestination(isPresented: $viewModel.isLoggedIn, destination: {
            MainView()
                .navigationBarBackButtonHidden()
        })

    }
}

#Preview {
    SignupView()
        .environmentObject(AuthenticationViewModel())
}
