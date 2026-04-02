//
//  A2_iOS_Arina_101418340App.swift
//  A2_iOS_Arina_101418340
//
//  Created by amir sayad on 2026-04-02.
//

import SwiftUI

@main
struct A2_iOS_Arina_101418340App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
