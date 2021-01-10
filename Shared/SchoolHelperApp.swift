//
//  SchoolHelperApp.swift
//  Shared
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI

@main
struct SchoolHelperApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
