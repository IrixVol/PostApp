//
//  PostService.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation

protocol PostsRequestServiceProtocol {
    
    var favourPostIds: Set<Int> { get }
    func toggleFavour(postId: Int)
    func getPosts(completion: @escaping ([PostApiModel], Error?) -> Void)
    func getComments(postId: Int, completion: @escaping ([CommentApiModel], Error?) -> Void)
}

final class PostsRequestService: PostsRequestServiceProtocol {
    
    let userService: UserServiceProtocol
    let coreDatabase: CoreDatabaseServiceProtocol
    lazy var favourPostIds: Set<Int> = {
        Set(coreDatabase.getFavourPostIds(userId: userService.currentUserId))
    }()
    
    init(userService: UserServiceProtocol,
         coreDatabase: CoreDatabaseServiceProtocol) {
        
        self.userService = userService
        self.coreDatabase = coreDatabase
    }

    func getPosts(completion: @escaping ([PostApiModel], Error?) -> Void) {

        RequestBuilder()
            .setHttpMethod(.get)
            .setApiMethod("posts")
            .addParam(key: "userId", value: userService.currentUserId)
            .execute { [weak self] (result: Result<[PostApiModel], Error>) in

                guard let self = self else { return }
                switch result {
                case .success(let result):
                    self.coreDatabase.savePosts(userId: self.userService.currentUserId, posts: result)
                    completion(result, nil)
                case .failure(let error):
                    let cachedPosts = self.coreDatabase.getPosts(userId: self.userService.currentUserId)
                    completion(cachedPosts, error)
                }
            }
    }
    
    func getComments(postId: Int, completion: @escaping ([CommentApiModel], Error?) -> Void) {
        
        RequestBuilder()
            .setHttpMethod(.get)
            .setApiMethod("comments")
            .addParam(key: "postId", value: postId)
            .execute { (result: Result<[CommentApiModel], Error>) in
                
                switch result {
                case .success(let result):
                    
                    self.coreDatabase.saveComments(postId: postId, comments: result)
                    completion(result, nil)
                    
                case .failure(let error):
                    let cachedPosts = self.coreDatabase.getComments(postId: postId)
                    completion(cachedPosts, error)
                }
            }
    }

    func toggleFavour(postId: Int) {
        
        let isFavour: Bool = !favourPostIds.contains(postId)
        if isFavour {
            favourPostIds.insert(postId)
        } else {
            favourPostIds.remove(postId)
        }
        coreDatabase.setFavour(postId: postId, userId: userService.currentUserId, isFavour)
    }
}
