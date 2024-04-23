//
//  NavigationSplitViewTutorial.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct NavigationSplitViewTutorial: View {
    @State var visibility: NavigationSplitViewVisibility = .automatic
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            //Side bar
            Text("Side Bar")
        } content: {
            Text("Main content")
        } detail: {
            Text("Detail content")
        }
        .navigationSplitViewStyle(.balanced)


    }
}

struct NavigationSplitViewTutorial_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitViewTutorial()
    }
}
