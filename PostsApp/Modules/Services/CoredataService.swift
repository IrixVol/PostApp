//
//  CoreDatabaseService.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

protocol CoreDatabaseServiceProtocol {
 
    func saveUser(_ user: UserApiModel)
    func getUser(userId: Int) -> UserApiModel?
    func savePosts(userId: Int, posts: [PostApiModel])
    func getPosts(userId: Int) -> [PostApiModel]
    func getFavourPostIds(userId: Int) -> [Int]
    func setFavour(postId: Int, userId: Int, _ isFavour: Bool)
    func saveComments(postId: Int, comments: [CommentApiModel])
    func getComments(postId: Int) -> [CommentApiModel]
}

final class CoreDatabaseService: CoreDatabaseServiceProtocol {
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveUser(_ user: UserApiModel) {
        CDUser.saveUser(user, context: context)
    }

    func getUser(userId: Int) -> UserApiModel? {
        CDUser.getUser(userId: userId, context: context)?.apiModel
    }
    
    func savePosts(userId: Int, posts: [PostApiModel]) {
        CDPost.savePosts(userId: userId, posts: posts, context: context)
    }
    
    func getPosts(userId: Int) -> [PostApiModel] {
        CDPost.getPosts(userId: userId, context: context)
    }
    
    func getFavourPostIds(userId: Int) -> [Int] {
        CDFavour.getFavourPostIds(userId: userId, context: context)
    }
    
    func setFavour(postId: Int, userId: Int, _ isFavour: Bool) {
        CDFavour.setFavour(postId: postId, userId: userId, isFavour, context: context)
    }
    
    func saveComments(postId: Int, comments: [CommentApiModel]) {
        CDComment.saveComments(postId: postId, comments: comments, context: context)
    }
    
    func getComments(postId: Int) -> [CommentApiModel] {
        CDComment.getComments(postId: postId, context: context)
    }
}
