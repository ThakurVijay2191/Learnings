//
//  SplashView.swift
//  PopToRoot
//
//  Created by Nap Works on 10/12/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool
    var body: some View {
       Text("Splash View")
            .onAppear(perform: {
                print("isActive?: \(isActive)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    isActive = true
                }
            })
    }
    
}

#Preview {
    ContentView()
}
