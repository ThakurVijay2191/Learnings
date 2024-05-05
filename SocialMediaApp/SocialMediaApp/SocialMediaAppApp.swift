//
//  SocialMediaAppApp.swift
//  SocialMediaApp
//
//  Created by Nap Works on 23/09/23.
//

import SwiftUI
import Firebase

@main
struct SocialMediaAppApp: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

