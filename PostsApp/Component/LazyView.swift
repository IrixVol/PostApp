//
//  LazyView.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

/// Problem: NavigationLink initialize destination view immediately, even isActive is false
/// https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
struct LazyView<Content: View>: View {
    
    let wrapped: () -> Content
    init(_ wrapped: @autoclosure @escaping () -> Content) {
        self.wrapped = wrapped
    }
    var body: Content {
        wrapped()
    }
}
