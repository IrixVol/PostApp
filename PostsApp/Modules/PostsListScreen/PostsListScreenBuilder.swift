//
//  PostsListScreenBuilder.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 01.01.2023.
//

import SwiftUI

final class PostsListScreenBuilder {
    
    static func lazy() -> some View {
        LazyView(build())
    }
    
    static func build() -> some View {
        
        let container = DIContainer.share
        let viewModel = PostsListScreenModel(postsService: container.postRequestService)
        return PostsListScreen(viewModel: viewModel)
    }
}
