//
//  PostsListScreenModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI
import Combine

final class PostsListScreenModel: ObservableObject {
    
    @Published var showOnlyFavour: Bool = false
    @Published var allItems: [PostListItemViewModel] = []
    @Published var tabBarModel = TabBarViewModel(items: []) {
        didSet {
            showOnlyFavour = tabBarModel.current == 1
        }
    }
    
    // ToastView to show alert, for example when internet connection is krea
    @Published var toast: ToastViewModel?
    
    private var cancellable = Set<AnyCancellable>()
    
    // If list of favours is empty, show stab
    var stabModel: StabViewModel? {
        
        guard showOnlyFavour && items.isEmpty else { return nil }
        
        return StabViewModel(
            image: Image(systemName: "star"),
            title: "No posts in favorites!".localized,
            subtitle: "To add post to your favorites, click on the star symbol in the top right corner of the post.".localized
        )
    }

    var items: [PostListItemViewModel] {
        
        if showOnlyFavour {
            return allItems.filter { $0.isFavour == true }
        }
        return allItems
    }
    
    private var postsService: PostsRequestServiceProtocol
    
    init( postsService: PostsRequestServiceProtocol) {
        
        self.postsService = postsService
        self.tabBarModel = makeTabBarViewModel()
        
        getPosts()
        
        $toast
            .debounce(for: .seconds(3), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.toast = nil
            }
            .store(in: &cancellable)
    }
    
    private func toggleFavour(postId: Int) {

        postsService.toggleFavour(postId: postId)
        if let index = allItems.firstIndex(where: { $0.id == postId }) {
            allItems[index].isFavour.toggle()
        }
    }
    
    internal func getPosts() {

        postsService.getPosts { [weak self] posts, error in
            
            guard let self = self else { return }
            self.handlePosts(posts)
            
            if let error = error {
                self.toast = ToastViewModel(.warning, error.localizedDescription)
            }
        }
    }
    
    func handlePosts(_ posts: [PostApiModel]) {
        
        let favourIds = postsService.favourPostIds
        
        allItems = posts.map { item in
            
            PostListItemViewModel(
                apiModel: item,
                isFavour: favourIds.contains(item.id),
                tapAction: { },
                tapFavourAction: { [weak self] in
                    self?.toggleFavour(postId: item.id)
                })
        }
    }
    
    func updateFavours() {
        
        let favourIds = self.postsService.favourPostIds
        
        (0..<allItems.count).forEach { i in
            allItems[i].isFavour = favourIds.contains(allItems[i].id)
        }
    }
    
    private func makeTabBarViewModel() -> TabBarViewModel {
        
        return .init(items: [
            
            TabItemViewModel(
                isSelected: true,
                text: "All".localized,
                image: Image(systemName: "folder"),
                selectedImage: Image(systemName: "folder.fill")
            ),
            
            TabItemViewModel(
                isSelected: false,
                text: "Favour".localized,
                image: Image(systemName: "star"),
                selectedImage: Image(systemName: "star.fill")
            )
        ])
    }
}
