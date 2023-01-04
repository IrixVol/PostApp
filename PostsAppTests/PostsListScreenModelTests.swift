//
//  PostsListScreenModelTests.swift
//  PostsAppTests
//
//  Created by Tatiana Blagoobrazova on 05.01.2023.
//

import XCTest
@testable import PostsApp

final class PostsListScreenModelTests: XCTestCase {
    
    private var postsService = PostsRequestServiceMock()
    private var viewModel: PostsListScreenModel!
    
    override func setUpWithError() throws {
        viewModel = PostsListScreenModel(postsService: postsService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_getPosts_checkFavours() throws {
        
        // given
        viewModel.showOnlyFavour = true
        let expect = expectation(description: "service")
        postsService.getPosts { _, _ in
            expect.fulfill()
        }
        
        // when
        viewModel.getPosts ()
        wait(for: [expect], timeout: 1)
        
        // then
        XCTAssertEqual(self.viewModel.items.count, 1)
        XCTAssertEqual(self.viewModel.allItems.count, 3)
    }
    
    func test_getPosts_checkAll() throws {
        
        // given
        viewModel.showOnlyFavour = false
        let expect = expectation(description: "service")
        postsService.getPosts { _, _ in
            expect.fulfill()
        }
        
        // when
        viewModel.getPosts ()
        wait(for: [expect], timeout: 1)
        
        // then
        XCTAssertEqual(self.viewModel.items.count, 3)
        XCTAssertEqual(self.viewModel.allItems.count, 3)
    }
}

// I used swiftymocky framework to codogeneration, but it's easy to create stubs for protocols
private final class PostsRequestServiceMock: PostsRequestServiceProtocol {
    
    var favourPostIds: Set<Int> = Set([2])
    
    func toggleFavour(postId: Int) { }
    
    func getPosts(completion: @escaping ([PostApiModel], Error?) -> Void) {
        
        completion([
            PostApiModel(id: 1, userId: 1, title: "title1", body: "body1"),
            PostApiModel(id: 2, userId: 1, title: "title2", body: "body2"),
            PostApiModel(id: 3, userId: 1, title: "title3", body: "body3")
        ], nil)
        
    }
    
    func getComments(postId: Int, completion: @escaping ([CommentApiModel], Error?) -> Void) { }
}
