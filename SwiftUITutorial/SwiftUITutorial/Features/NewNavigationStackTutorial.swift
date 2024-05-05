//
//  NewNavigationStackTutorial.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct NewNavigationStackTutorial: View {
    //Programmatic stack
    @State var stack = NavigationPath()
    var body: some View {
        NavigationStack(path: $stack) {
            NavigationLink("Navigate to New view", value: "Vijay Thakur")
            .navigationDestination(for: String.self) { value in
                VStack {
                    NavigationLink("Navigate to New view", value: "Vaidu")

                    Text("Detail Page: \(value)")
                    Button("Pop to root"){
                        stack = .init()
                    }
                }
            }
        }
    }
}

struct NewNavigationStackTutorial_Previews: PreviewProvider {
    static var previews: some View {
        NewNavigationStackTutorial()
    }
}
