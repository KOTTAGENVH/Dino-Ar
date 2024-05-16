//
//  Dino_ARApp.swift
//  Dino-AR
//
//  Created by Nowen on 2024-05-16.
//

import SwiftUI

@main
struct Dino_ARApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
