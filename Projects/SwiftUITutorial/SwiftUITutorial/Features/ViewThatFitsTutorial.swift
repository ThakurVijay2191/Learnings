//
//  ViewThatFitsTutorial.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct ViewThatFitsTutorial: View {
    var body: some View {
        //It often used for adopting views between custom screen sizes
        //We will provide a set of views then it will take the appropriate view based on the available size
        //It will pick which is the best fitting view
        VStack {
            CustomView()
                .frame(width: 100)
            CustomView()
                .frame(width: 50)
            CustomView()
                .frame(width: 150)
        }
    }
    
    @ViewBuilder
    func CustomView()-> some View {
        ViewThatFits(in: .horizontal) {
            //First View
            HStack {
                Rectangle()
                    .frame(width: 100, height: 10)
                
                Text("Bar")
            }
            //Second View
            Rectangle()
                .frame(width: 80, height: 10)
            //Third View
            Text("Bar")
        }
    }
}

struct ViewThatFitsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ViewThatFitsTutorial()
    }
}
