//
//  NavigationBarAppearance.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 02.01.2023.
//

import SwiftUI

struct AppNavigationBarAppearance: ViewModifier {
    
    init() {

        let appearance = UINavigationBarAppearance()
        
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(Color.background)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(Color.accent)
        UINavigationBar.appearance().barTintColor = UIColor(Color.accent)
        UIView.appearance(whenContainedInInstancesOf: [UIViewController.self]).tintColor = UIColor(Color.accent)
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    
    func setupNavigationViewAppearance() -> some View {
        modifier(AppNavigationBarAppearance())
    }
}
