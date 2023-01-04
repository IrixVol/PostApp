//
//  CommentListItemViewModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

struct CommentListItemViewModel: Identifiable {
    
    var id: Int
    var name: String
    var body: String
    var email: String?
    var autor: String?
}

extension CommentListItemViewModel {
    
    init(apiModel: CommentApiModel) {
        
        self.id = apiModel.id
        self.name = apiModel.name
        self.body = apiModel.body
        self.email = apiModel.email
    }
}
