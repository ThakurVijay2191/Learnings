//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Nap Works on 10/09/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //Setting up the container
        .modelContainer(for: [Expense.self, Category.self])
    }
}
