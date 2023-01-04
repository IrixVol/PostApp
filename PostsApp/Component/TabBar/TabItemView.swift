//
//  TabItem.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

struct TabItemView: View {
    
    var model: TabItemViewModel

    var body: some View {
        
        VStack(alignment: .center) {
            (model.isSelected ? model.selectedImage : model.image)
                .font(.title3)
            Spacer().frame(height: 4)
            Text(model.text)
                .font(.caption)
        }
        .foregroundColor(model.isSelected ? model.selectedTintColor: model.tintColor)
        .frame(maxWidth: .infinity)
    }
}

extension TabItemView {
    
    init(model: TabItemViewModel, isSelected: Bool) {
        self.model = model
        self.model.isSelected = isSelected
    }
}

struct TabItem_Previews: PreviewProvider {
    
    static var previews: some View {

        TabItemView(model: .init(
            isSelected: true,
            text: "All".localized,
            image: Image(systemName: "folder"),
            selectedImage: Image(systemName: "folder.fill")
        ))
    }
}
