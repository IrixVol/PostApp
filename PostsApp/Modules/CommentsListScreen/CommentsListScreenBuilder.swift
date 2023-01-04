//
//  CommentsListScreenBuilder.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

class CommentsListScreenBuilder {
    
    static func lazy(post: PostListItemViewModel) -> some View {
        LazyView(build(post: post))
    }
    
    static func build(post: PostListItemViewModel) -> some View {
        
        let postsService = DIContainer.share.postRequestService
        let viewModel = CommentsListScreenModel(post: post, postsService: postsService)
        return CommentsListScreen(viewModel: viewModel)
    }
}
