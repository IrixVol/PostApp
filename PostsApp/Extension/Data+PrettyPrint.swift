//
//  Data+PrettyPrint.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

extension Data {

     var prettyPrintedJsonString: String? {

        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: [.fragmentsAllowed]),
              let data =  try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            
            return String(data: self, encoding: .utf8)
        }
        
        return String(data: data, encoding: .utf8)
    }
}
