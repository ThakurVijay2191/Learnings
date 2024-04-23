//
//  ContentView.swift
//  TodoListAppCoreData
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("To-Do")
        }
    }


}



#Preview {
    ContentView()
}
