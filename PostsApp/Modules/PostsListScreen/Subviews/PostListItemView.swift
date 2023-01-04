//
//  PostListItemView.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI

struct PostListItemView: View {

    var model: PostListItemViewModel
    @State var animatedFavour: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            HStack {
                
                Text(model.title)
                    .foregroundColor(Color.text)
                    .font(.title3)

                Spacer(minLength: 8)
                
                Image(systemName: model.isFavour ? "star.fill" : "star")
                    .font(.title3)
                    .foregroundColor(Color.accent)
                    .padding(.all, 6)
                    .background(
                        Circle().stroke(lineWidth: 1).fill(Color.accent)
                            
                    )
                    .scaleEffect(animatedFavour ? 1.3 : 1)
                    .animation(.linear(duration: 0.3), value: animatedFavour)
                    .onTapGesture {
                        self.animatedFavour = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.animatedFavour = false
                        }
                        model.tapFavourAction?()
                    }
            }

            Spacer().frame(height: 5)
            Text(model.body)
                .foregroundColor(Color.textDescription)
        }

        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.secondaryBackground)
                .shadow(color: .black.opacity(0.4),
                        radius: 5, x: 0, y: 2)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
}

struct PostListItemView_Previews: PreviewProvider {

    static var previews: some View {

        let viewModel = PostListItemViewModel(
            id: 11,
            isFavour: false,
            userId: 1,
            title: "et ea vero quia laudantium autem",
            body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi",
            autor: "Martin Fauler"
        )

        List() {
            PostListItemView(model: viewModel)
                .listRowInsets(EdgeInsets())
                .listRowSeparatorTint(.clear)
                .listRowSeparator(.hidden)
        }
        .preferredColorScheme(.dark)
        .listStyle(.plain)
    }
}
