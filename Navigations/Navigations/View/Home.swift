//
//  Home.swift
//  Navigations
//
//  Created by Nap Works on 05/05/24.
//

import SwiftUI

struct Home: View {
    @State private var path: [String] = []
    var body: some View {
        NavigationStack(path: $path) {
            Button(action: {
                path.append("Screen 1")
            }, label: {
                Text("Home")
            })
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { value in
                if value == "Screen 1" {
                    Button(action:{
                        path.append("Screen 2")
                    } , label: {
                        Text("Screen 1")
                    })
                }else if value == "Screen 2"{
                    Button(action:{
                        path.append("Screen 3")
                    } , label: {
                        Text("Screen 2")
                    })
                }else if value == "Screen 3" {
                    Button(action:{
                        path.removeAll()
                    } , label: {
                        Text("Screen 3")
                    })
                }
            }
        }
    }
}

#Preview {
    Home()
}
