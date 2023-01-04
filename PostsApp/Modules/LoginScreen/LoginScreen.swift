//
//  LoginScreen.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import SwiftUI
import Combine

struct LoginScreen: View {
    
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel: LoginScreenModel

    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 4) {

                    Text(viewModel.hint)
                        .font(.caption)
                        .foregroundColor(Color.textDescription)
                    
                    TextField("User ID".localized, text: $viewModel.userIdString)
                        .foregroundColor(Color.text)
                        .accentColor(Color.accent)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isFocused = true
                            }
                        }

                    Color.textDescription.frame(height: 0.5)
                    
                    Text(viewModel.loginErrorMessage)
                        .font(.caption)
                        .foregroundColor(Color.error)
                    
                    Spacer().frame(height: 8)
                  
                    NavigationLink(destination: PostsListScreenBuilder.lazy(),
                                   isActive: $viewModel.isLogged) { EmptyView() }

                    PrimaryButton(isEnabled: $viewModel.isLoginButtonEnabled,
                                  text: "Login".localized) {
                        viewModel.checkUser()
                    }
                }
                
                .frame(width: geometry.size.width * 0.5, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .offset(y: -100)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("", displayMode: .inline)
        }
        .setupNavigationViewAppearance()
    }
}

struct LoginScreen_Previews: PreviewProvider {
   
    static var previews: some View {
        LoginScreenBuilder.build()
    }
}

struct LoginScreen_Previews_Dark: PreviewProvider {
    static var previews: some View {
        LoginScreenBuilder.build()
           .preferredColorScheme(.dark)
    }
}
