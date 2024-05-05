//
//  NewGridsTutorial.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct NewGridsTutorial: View {
    var body: some View {
        Grid{
            GridRow{
                Color.blue
                    .frame(width: 30, height: 30)
                Color.blue
                    .frame(width: 30, height: 30)
                Color.blue
                    .frame(width: 30, height: 30)
            }
            Divider()
                .background(.red)
            //to avoid this use cell unsized
            //it will take only the required size
                .gridCellUnsizedAxes(.horizontal)
            GridRow{
                Color.blue
                    .frame(width: 30, height: 30)
            }
        }
        .frame(height: 200)
    }
}

struct NewGridsTutorial_Previews: PreviewProvider {
    static var previews: some View {
        NewGridsTutorial()
    }
}
