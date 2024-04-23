//
//  ThirdView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct ThirdView: View {
    var body: some View {
        Button {
            UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
            RootController.auth.send(false)
        } label: {
           Text("Pop to Splash")
        }

    }
}

#Preview {
    ContentView()
}
