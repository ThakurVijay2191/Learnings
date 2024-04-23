//
//  FirstView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack {
            NavigationLink {
                SecondView()
            } label: {
                Text("Go to second view")
            }
        }
        .navigationTitle("Home")

    }
}

#Preview {
    FirstView()
}
