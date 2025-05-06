//
//  CalorieCamApp.swift
//  CalorieCam
//
//  Created by Michael Gibby on 5/5/25.
//

import SwiftUI

@main
struct CalorieCamApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
