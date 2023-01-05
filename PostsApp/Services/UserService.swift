//
//  UserService.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation

protocol UserServiceProtocol {
    
    var currentUserId: Int { get }
    func getUser(userId: Int, completion: @escaping (Result<Int, Error>) -> Void)
}

final class UserService: UserServiceProtocol {
    
    var currentUserId: Int = 0
    let coreDatabase: CoreDatabaseServiceProtocol
    
    init(coreDatabase: CoreDatabaseServiceProtocol) {
        self.coreDatabase = coreDatabase
    }

    func getUser(userId: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        
        RequestBuilder()
            .setHttpMethod(.get)
            .setApiMethod("users")
            .addParam(key: "id", value: userId)
            .execute { [weak self] (result: Result<[UserApiModel], Error>) in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let result):
                    
                    if let user = result.first {
                        self.coreDatabase.saveUser(user)
                        self.currentUserId = userId
                        return completion(.success(userId))
                    }
                    
                    return completion(.failure(ApiError.error(message: "Invalid user ID".localized)))
                    
                case .failure(let error):
                    
                    if let cachedUser = self.coreDatabase.getUser(userId: userId) {
                        self.currentUserId = userId
                        return completion(.success(cachedUser.id))
                    }
                    
                    return completion(.failure(error))
                }
            }
    }
}
