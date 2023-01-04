//
//  DIContainer.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation

/// Primitive of DI Container
final class DIContainer {
    
    static let share = DIContainer()
    
    let coreDatabase: CoreDatabaseService
    let userService: UserService
    let postRequestService: PostsRequestService
    
    init() {
        self.coreDatabase = CoreDatabaseService(context: PersistenceCoordinator.shared.context)
        self.userService = UserService(coreDatabase: self.coreDatabase)
        self.postRequestService = PostsRequestService(userService: self.userService,
                                                      coreDatabase: self.coreDatabase)
    }
}
