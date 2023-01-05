//
//  CommentApiModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

struct CommentApiModel: Codable {
    
    var id: Int
    var postId: Int
    var name: String
    var body: String
    var email: String?
}
