
//
//  ToasterViewModifier.swift
//  SwiftKitUI
//
//  Created by Tatiana Blagoobrazova on 05.01.2023.
//

import Foundation
import SwiftUI

/// Modifier shows toast with animation when model is not nil
/// Example of call: .showToast($tostModel, topInset: topInset)
public struct ToastViewModifier: ViewModifier {
    
    var toastModel: Binding<ToastViewModel?>
    let topInset: CGFloat
    
    public init(toastModel: Binding<ToastViewModel?>, topInset: CGFloat) {
        
        self.toastModel = toastModel
        self.topInset = topInset
    }
    
    private var toastView: ToastView? {
        
        if let model = toastModel.wrappedValue {
            return ToastView(model: model)
        }
        
        return nil
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(popupView, alignment: .top)
    }
    
    @ViewBuilder private var popupView: some View {
        
        if let toastView = toastView {
            
            VStack(spacing: 0) {
                Spacer().frame(height: topInset)
                toastView
            }
            .transition(AnyTransition.move(edge: .top))
            .animation(.linear(duration: animationDuration))
        }
    }
}

public extension View {
    
    @ViewBuilder func showToast(_ toastModel: Binding<ToastViewModel?>,
                                topInset: CGFloat = 0) -> some View {
        
        modifier(ToastViewModifier(toastModel: toastModel, topInset: topInset))
    }
}
