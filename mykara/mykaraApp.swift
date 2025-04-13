//
//  mykaraApp.swift
//  mykara
//
//  Created by Yo_4040 on 2025/04/07.
//

import SwiftUI
import SwiftData

@main
struct mykaraApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Music.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
