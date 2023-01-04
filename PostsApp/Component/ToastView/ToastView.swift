//
//  ToastView.swift
//  SwiftKitUI
//
//  Created by Tatiana Blagoobrazova on 05.01.2023.
//

import SwiftUI

public struct ToastView: View {
    
    let model: ToastViewModel
    
    public var body: some View {
        
        Text(model.message)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(model.style.backgroundColor)
    }
}

struct ToastView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToastView(model: .init(.success, "Video 5 of the SwiftUI development lecture series"))
    }
    
}
