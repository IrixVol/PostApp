//
//  CommentsListScreenModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

final class CommentsListScreenModel: ObservableObject {

    @Published var post: PostListItemViewModel
    @Published var items: [CommentListItemViewModel] = []
    
    private var postsService: PostsRequestServiceProtocol
    
    init(post: PostListItemViewModel,
         postsService: PostsRequestServiceProtocol) {
        
        self.post = post
        self.postsService = postsService
        
        self.post.tapFavourAction = { [weak self] in
            self?.toggleFavour(postId: post.id)
        }
        
        getComments()
    }

    private func toggleFavour(postId: Int) {
        
        postsService.toggleFavour(postId: postId)
        post.isFavour.toggle()
    }
    
    private func getComments() {
        
        postsService.getComments(postId: post.id) { [weak self] comments, error in
            
            guard let self = self else { return }
            
            self.items = comments.map { item in
                
                CommentListItemViewModel(id: item.id,
                                         name: item.name,
                                         body: item.body,
                                         email: item.email)
            }
            
            // TODO: Toast with error
        }
    }
}
