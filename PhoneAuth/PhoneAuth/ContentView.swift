//
//  ContentView.swift
//  PhoneAuth
//
//  Created by Nap Works on 11/02/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var log_status = false
    var body: some View {
        NavigationStack {
            if log_status {
                Text("Home")
                    .navigationTitle("Home")
            }else {
                Login()
            }
           
        }
    }
}

#Preview {
    ContentView()
}
