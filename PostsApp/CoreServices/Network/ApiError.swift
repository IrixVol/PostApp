//
//  APIError.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

enum ApiError: Error, LocalizedError {
    
    case unknown
    case dataNotFound // 404 - error
    case error(code: Int = 0, message: String)
    case invalidDecoder
    
    var errorDescription: String? {
        switch self {
        case .unknown: return "Something was wrong".localized
        case .error(_, let message): return message
        case .invalidDecoder: return "Something was wrong".localized
        case .dataNotFound: return "Data not fount".localized
        }
    }
}

extension ApiError: Equatable {
    
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        
        switch (lhs, rhs) {
        case (.unknown, .unknown): return true
        case (.invalidDecoder, .invalidDecoder): return true
        case (.dataNotFound, .dataNotFound): return true
        case (.error(let lhsCode, let lhsMessage), .error(let rhsCode, let rhsMessage)):
            return lhsCode == rhsCode && lhsMessage == rhsMessage
        default: return false
        }
    }
}
