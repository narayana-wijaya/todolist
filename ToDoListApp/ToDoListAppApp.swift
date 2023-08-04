//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//

import SwiftUI

@main
struct ToDoListAppApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var errorState = ErrorState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(errorState)
                .fullScreenCover(item: $errorState.errorWrapper) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
        }
    }
}
