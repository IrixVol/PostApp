//
//  PostListItemViewModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI

struct PostListItemViewModel: Identifiable {
    
    var id: Int
    var isFavour: Bool
    var userId: Int
    var title: String
    var body: String
    var autor: String?
    
    var tapFavourAction: (() -> Void)?
    var tapAction: (() -> Void)?
}

extension PostListItemViewModel {
    
    init(apiModel: PostApiModel,
         isFavour: Bool,
         tapAction: @escaping () -> Void,
         tapFavourAction: @escaping () -> Void) {

        self.id = apiModel.id
        self.isFavour = isFavour
        self.userId = apiModel.userId
        self.title = apiModel.title
        self.body = apiModel.body
        
        self.tapFavourAction = tapFavourAction
        self.tapAction = tapAction
        
    }
    
    init(apiModel: PostApiModel,
         isFavour: Bool) {
        
        self.id = apiModel.id
        self.isFavour = false
        self.userId = apiModel.userId
        self.title = apiModel.title
        self.body = apiModel.body
        
    }
}
