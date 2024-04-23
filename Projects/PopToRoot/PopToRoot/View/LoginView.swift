//
//  LoginView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct LoginView: View {
    @State private var isUserLoggedIn: Bool = false
    var body: some View {
        VStack {
            Button {
                UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                isUserLoggedIn = true
            } label: {
                Text("Login")
            }
            
            NavigationLink("", destination: FirstView().navigationBarBackButtonHidden(), isActive: $isUserLoggedIn)
        }

    }
}

#Preview {
    LoginView()
}
