//
//  PostsRequestServiceTests.swift
//  PostsRequestServiceTests
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import XCTest
@testable import PostsApp

final class PostsRequestServiceTests: XCTestCase {

    var service: PostsRequestService!
    
    override func setUpWithError() throws {
       
        service = PostsRequestService(userService: UserServiceMock(), coreDatabase: CoreDatabaseServiceMock())
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func test_toggleFavour_insert() throws {
        
        // given
        let favourPostId = 12
        service.favourPostIds = []
        
        // when
        service.toggleFavour(postId: favourPostId)
        
        // then
        XCTAssert(service.favourPostIds.contains(favourPostId))
    }

    func test_toggleFavour_remove() throws {
        
        // given
        let favourPostId = 12
        service.favourPostIds = [favourPostId]
        
        // when
        service.toggleFavour(postId: favourPostId)
        
        // then
        XCTAssertFalse(service.favourPostIds.contains(favourPostId))
    }

}

// I used swiftymocky framework to codogeneration, but it's easy to create stubs for protocols
private final class UserServiceMock: UserServiceProtocol {
    
    var currentUserId: Int = 1
    
    func getUser(userId: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        completion(.success(1))
    }
}

private final class CoreDatabaseServiceMock: CoreDatabaseServiceProtocol {
    
    func saveUser(_ user: UserApiModel) { }
    
    func getUser(userId: Int) -> UserApiModel? { UserApiModel(id: 1, name: "", username: "") }
    
    func savePosts(userId: Int, posts: [PostApiModel]) { }
    
    func getPosts(userId: Int) -> [PostApiModel] { [] }
    
    func getFavourPostIds(userId: Int) -> [Int] { [] }
    
    func setFavour(postId: Int, userId: Int, _ isFavour: Bool) { }
    
    func saveComments(postId: Int, comments: [CommentApiModel]) { }
    
    func getComments(postId: Int) -> [CommentApiModel] { [] }
}
