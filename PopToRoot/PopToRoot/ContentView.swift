//
//  ContentView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView(content: {
            VStack(content: {
                SplashView(isActive: $isActive)
                if isLoggedIn {
                    NavigationLink("", destination: FirstView().navigationBarBackButtonHidden(), isActive: $isActive)
                }else {
                    NavigationLink("", destination: LoginView(), isActive: $isActive)
                }
            })
        })
        .onAppear(perform: {
            self.isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as! Bool

        })
        .onReceive(RootController.auth, perform: { newValue in
            isActive = newValue
            if newValue == false{
                self.isLoggedIn = false
            }
        })
    }
}

#Preview {
    ContentView()
}
