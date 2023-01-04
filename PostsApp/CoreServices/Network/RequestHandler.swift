//
//  RequestHandler.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

final class RequestHandler {
    
    static let decoder = JSONDecoder()
    
    static func handle<T: Codable>(data: Data?,
                                   response: URLResponse?,
                                   error: Error?,
                                   request: URLRequest,
                                   dispatchToMain: Bool,
                                   completion: @escaping (Result<T, Error>) -> Void) {

        RequestLogger.logRequest(request, data: data, response: response, error: error)
        
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            200 ..< 300 ~= response.statusCode,
            error == nil
        else {
            let error = (response as? HTTPURLResponse)?.statusCode == 404 ? ApiError.dataNotFound : error
            dispatch(dispatchToMain, completion, result: .failure(error ?? ApiError.unknown))
            return
        }
        
        guard let parsed = try? decoder.decode(T.self, from: data) else {
            dispatch(dispatchToMain, completion, result: .failure(ApiError.invalidDecoder))
            return
        }

        dispatch(dispatchToMain, completion, result: .success(parsed))
    }
    
    static func dispatch<T>(_ toMain: Bool,
                            _ completion: @escaping ((Result<T, Error>) -> Void),
                            result: (Result<T, Error>)) {
        
        guard toMain else {
            completion(result)
            return
        }

        DispatchQueue.main.async {
            completion(result)
        }
    }
}
