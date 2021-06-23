//
//  bookWormUIApp.swift
//  bookWormUI
//
//  Created by Максим Нуждин on 23.06.2021.
//

import SwiftUI

@main
struct bookWormUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
