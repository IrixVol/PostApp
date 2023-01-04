//
//  ToastViewModel.swift
//  SwiftKitUI
//
//  Created by Tatiana Blagoobrazova on 05.01.2023.
//

import SwiftUI

public struct ToastViewModel {
    
    public var style: Style
    public var message: String
    
    init(_ style: Style, _ message: String) {
        
        self.style = style
        self.message = message
    }
}

extension ToastViewModel {
    
    public enum Style {
        
        case success
        case warning
        case error
        
        var backgroundColor: Color {
            
            switch self {
            case .success: return Color.accent
            case .warning: return Color.error
            case .error: return Color.error
            }
        }
    }
}
