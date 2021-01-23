//
//  SchoolHelperApp.swift
//  Shared
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI
import UserNotifications

@main
struct SchoolHelperApp: App {
    let persistenceController = PersistenceController.shared
    let hasOnboarded: Bool
    
    init() {
        let defaults = UserDefaults.standard
        hasOnboarded = defaults.bool(forKey: "hasOnboarded")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {success, error  in
            if success {
                print("Notifications Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
