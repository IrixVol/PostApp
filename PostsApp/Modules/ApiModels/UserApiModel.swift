//
//  UserApiModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

struct UserApiModel: Codable {
    
    var id: Int
    var name: String
    var username: String
    var email: String?
    
}
