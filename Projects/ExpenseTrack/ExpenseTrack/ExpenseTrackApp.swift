//
//  ExpenseTrackApp.swift
//  ExpenseTrack
//
//  Created by Nap Works on 23/03/24.
//

import SwiftUI

@main
struct ExpenseTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
