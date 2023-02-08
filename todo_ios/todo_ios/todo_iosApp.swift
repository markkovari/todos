//
//  todo_iosApp.swift
//  todo_ios
//
//  Created by Mark Kovari on 2023. 02. 08..
//

import SwiftUI

@main
struct todo_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
