//
//  LoginScreenModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 01.01.2023.
//

import SwiftUI

final class LoginScreenModel: ObservableObject {

    @Published var isLogged: Bool = false
    @Published var isLoginButtonEnabled: Bool = false
    @Published var loginErrorMessage: String = ""
    @Published var userIdString: String = "" {
        didSet {
            isLoginButtonEnabled = !userIdString.isEmpty
        }
    }
    
    var hint: String {
        userIdString.isEmpty ? " ": "User ID"
    }

    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    func checkUser() {
        
        guard let userId = Int(userIdString) else {
            loginErrorMessage = ApiError.error(message: "Invalid user ID".localized).localizedDescription
            return
        }
        
        loginErrorMessage = ""
        userService.getUser(userId: userId) { [weak self] (result: Result<Int, Error>) in
            
            switch result {
            case .success:
                self?.isLogged = true
                
            case .failure(let error):
                self?.loginErrorMessage = error.localizedDescription
            }
        }
    }
}
