//
//  LoginScreenBuilder.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

final class LoginScreenBuilder {
    
    // Resolve dependencies before view and viewModel initialization
    static func build() -> some View {
        
        let container = DIContainer.share
        let viewModel = LoginScreenModel(userService: container.userService)
        return LoginScreen(viewModel: viewModel)
    }
}
