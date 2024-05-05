//
//  ContentView.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let email = UserDefaultsMapper.getUser()?.email, !email.isEmpty {
            MainView()
        }else {
            AuthenticationView()
        }
    }
}

#Preview {
    ContentView()
}
