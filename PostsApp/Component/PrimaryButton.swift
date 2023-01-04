//
//  PrimaryButton.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI

struct PrimaryButton: View {
    
    @Binding var isEnabled: Bool
    @State private var isPressed: Bool = false
    
    let text: String
    var action: (() -> Void)?
    
    var body: some View {
        
        let isHighlited = isPressed || !isEnabled
        
        Text(text)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(Color.white)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16)
                
                    .fill(Color.accent.opacity(isHighlited ? 0.6 : 1))
                    .shadow(color: .black.opacity(isHighlited ? 0 : 0.4),
                            radius: 5, x: 0, y: 2)
            }
        
            .scaleEffect(isHighlited ? 0.95 : 1.0)
            .animation(.linear(duration: 0.3), value: isHighlited)
            .onTapGesture {
                if isEnabled {
                    action?()
                }
            }
            .simultaneousGesture(DragGesture(minimumDistance: 0.0)
                .onChanged { _ in
                    withAnimation { isPressed = true }
                }
                .onEnded { _ in
                    withAnimation { isPressed = false }
                }
            )
    }
}
