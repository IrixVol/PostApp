//
//  String+Extension.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 01.01.2023.
//

import Foundation

extension String {
    
    func removePrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    func removeSuffix(_ prefix: String) -> String {
        guard hasSuffix(prefix) else { return self }
        return String(dropLast(prefix.count))
    }
}
