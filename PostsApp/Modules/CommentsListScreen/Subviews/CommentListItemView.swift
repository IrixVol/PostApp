//
//  CommentListItemView.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

struct CommentListItemView: View {
    
    var model: CommentListItemViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            HStack(alignment: .top) {
                
                Image(systemName: "ellipsis.bubble")
                    .font(.title3)
                    .offset(y: 8)
                    .padding(.horizontal, 12)
                    .foregroundColor(Color.textDescription)
                
                VStack(alignment: .leading) {
                    Text(model.name)
                        .foregroundColor(Color.text)
                        .font(.title3)
                    
                    Spacer().frame(height: 5)
                    
                    Text(model.body)
                        .foregroundColor(Color.textDescription)
                        .font(.body)

                    Spacer().frame(height: 8)
    
                    Color.textDescription.frame(height: 0.5)

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
    }
    
    struct CommentListItemView_Previews: PreviewProvider {
        
        static var previews: some View {
            
            let viewModel = CommentListItemViewModel(
                id: 11,
                name: "et ea vero quia laudantium autem",
                body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi",
                email: "wwww",
                autor: "Martin Fauler"
            )
            
            List() {
                CommentListItemView(model: viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorTint(.clear)
                    .listRowSeparator(.hidden)
                CommentListItemView(model: viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparatorTint(.clear)
                    .listRowSeparator(.hidden)
            }
            .preferredColorScheme(.dark)
            .listStyle(.plain)
            
        }
    }
}
