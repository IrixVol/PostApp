//
//  PostsApp.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI

@main
struct PostsApp: App {
    
    let coordinator = PersistenceCoordinator.shared
    
    var body: some Scene {
        WindowGroup {
            LoginScreenBuilder.build()
                .environment(\.managedObjectContext, coordinator.container.viewContext)
        }
    }
}
