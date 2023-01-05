//
//  PostsListScreen.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI

var animationDuration: Double = 0.3

struct PostsListScreen<ViewModel>: View where ViewModel: PostsListScreenModelProtocol {
    
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        
        VStack(spacing: 0) {
            
            if let stabModel = viewModel.stabModel {
                StabView(model: stabModel)
                    .offset(y: -50)
                    .transition(.opacity.animation(Animation.linear(duration: animationDuration)))
                
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        NavigationLink(destination: CommentsListScreenBuilder.lazy(post: item)) {
                            PostListItemView(model: item)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorTint(.clear)
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
                .transition(.opacity.animation(Animation.linear(duration: animationDuration)))
            }
            
            TabBarView(model: $viewModel.tabBarModel)
                .background(Color.background)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
        }
        .onAppear {
            viewModel.updateFavours()
        }
        .showToast($viewModel.toast)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("My Posts".localized, displayMode: .inline)
    }
}

struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsListScreenBuilder.build()
    }
}

struct PostsList_Previews_Dark: PreviewProvider {
    static var previews: some View {
        PostsListScreenBuilder.build()
            .preferredColorScheme(.dark)
    }
}
