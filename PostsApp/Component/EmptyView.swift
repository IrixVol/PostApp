//
//  EmptyView.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazovaа on 04.01.2023.
//

import SwiftUI

struct StabView: View {
    
    var model: StabViewModel
    
    var body: some View {
        
        GeometryReader { geometryReader in
            
            VStack(alignment: .center, spacing: 16) {
                
                model.image
                    .foregroundColor(.accent)
                    .font(.title)
                
                Spacer().frame(height: 5)
                
                Text(model.title)
                    .foregroundColor(Color.text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Text(model.subtitle)
                    .foregroundColor(Color.textDescription)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            
            .frame(width: geometryReader.size.width * 0.7, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct StabViewModel {
    
    var image: Image
    var title: String
    var subtitle: String
}

struct StabView_Previews: PreviewProvider {

    static var previews: some View {
        
        StabView(
            model: StabViewModel(
                image: Image(systemName: "star"),
                title: "No posts in favorites!".localized,
                subtitle: "To add post to your favorites, click on the star symbol in the top right corner of the post.".localized
            )
        )
    }
}

