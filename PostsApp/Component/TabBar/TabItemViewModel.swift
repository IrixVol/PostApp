//
//  TabItemViewModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 04.01.2023.
//

import SwiftUI

struct TabItemViewModel {
    
    var isSelected: Bool = false
    var text: String
    var image: Image
    var selectedImage: Image
    
    var tintColor: Color = Color.textDescription
    var selectedTintColor: Color = Color.accent
}
