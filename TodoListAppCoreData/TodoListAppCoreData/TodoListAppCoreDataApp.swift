//
//  TodoListAppCoreDataApp.swift
//  TodoListAppCoreData
//
//  Created by Nap Works on 01/10/23.
//

import SwiftUI

@main
struct TodoListAppCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
