//
//  PostApiModel.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

struct PostApiModel: Codable {
    
    var id: Int
    var userId: Int
    var title: String
    var body: String
    
}
