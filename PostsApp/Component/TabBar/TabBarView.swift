//
//  TabBarView.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

/// If you have different View for earch tabItem, use TabView
struct TabBarView: View {
    
    @Binding var model: TabBarViewModel
    var body: some View {
        
        HStack(alignment: .center) {
            ForEach((0..<model.items.count), id: \.self) { i in
                
                TabItemView(model: model.items[i], isSelected: model.current == i)
                    .onTapGesture {
                        model.current = i
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .offset(y: 4)
    }
}

struct TabBarView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarViewDemo()
    }
}

struct TabBarViewDemo: View {
    
    @State var model = TabBarViewModel(items: [
        
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
    ]) {
        didSet {
            print("selected item: \(model.current)")
        }
    }

    var body: some View {
        
        VStack {
            Spacer()
            TabBarView(model: $model)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
