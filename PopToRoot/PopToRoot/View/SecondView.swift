//
//  SecondView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        NavigationLink {
            ThirdView()
        } label: {
            Text("Go to third view")
        }

    }
}

#Preview {
    SecondView()
}
