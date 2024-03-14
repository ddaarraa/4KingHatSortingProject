//
//  OneLastLastChanceApp.swift
//  OneLastLastChance
//
//  Created by dara sroin on 14/3/2567 BE.
//

import SwiftUI

@main
struct OneLastLastChanceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
