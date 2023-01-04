//
//  CommentsListScreen.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

struct CommentsListScreen: View {
    
    @ObservedObject var viewModel: CommentsListScreenModel
    
    init(viewModel: CommentsListScreenModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            PostListItemView(model: viewModel.post)
            
            List {
                ForEach(viewModel.items) { item in
                    CommentListItemView(model: item)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparatorTint(.clear)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("Comments", displayMode: .inline)
    }
}
