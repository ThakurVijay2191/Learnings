//
//  LoginViewModel.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showLoader: Bool = false
    @Published var showLoginAlert: Bool = false
    @Published var showSignupAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var stack: [Navigation] = []
    @Published var isLoggedIn: Bool = false
    @Published var goToSignup: Bool = false
    
    func signupUser(){
        if email.trimAndCheckIsEmpty() {
            self.setError("Please enter email.")
        }else if password.trimAndCheckIsEmpty() {
            self.setError("Please enter password.")
        }else if confirmPassword.trimAndCheckIsEmpty() {
            self.setError("Please confirm password.")
        }else if password != confirmPassword {
            self.setError("Password doesn't match.")
        }else {
            self.showLoader = true
            WebServiceManager.signup(email, password: password) { error, model in
                self.showLoader = false
                if error.isEmpty {
                    if let model{
                        try? UserDefaultsMapper.saveUser(model)
                        self.isLoggedIn = true
                    }
                }else {
                    self.setError(error)
                }
            }
        }

    }
    func loginUser(){
        if email.trimAndCheckIsEmpty() {
            self.setError("Please enter email", isLogin: true)
        }else if password.trimAndCheckIsEmpty() {
            self.setError("Please enter password", isLogin: true)
        }else {
            ///all set, call the login api
            self.showLoader = true
            WebServiceManager.login(email.trim(), password: password.trim()) { error, model in
                self.showLoader = false
                if error.isEmpty {
                    if let model {
                        try? UserDefaultsMapper.saveUser(model)
                        self.isLoggedIn = true
                    }
                }else {
                    self.setError(error, isLogin: true)
                }
            }
        }
    }
    
    func setError(_ message: String, isLogin: Bool = false){
        DispatchQueue.main.async {
            self.showLoginAlert = isLogin
            self.showSignupAlert = !isLogin
            self.alertMessage = message
        }
    }
}
