//
//  RequestLogger.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

final class RequestLogger {
    
    public static var isDebugMode: Bool = ProcessInfo.processInfo.environment["OS_ACTIVITY_MODE"] != nil
    
    public static func logRequest(_ request: URLRequest?, data: Data?, response: URLResponse?, error: Error?) {
        
        guard isDebugMode else {
            return
        }
        
        var logStr = "api_request.url = \(request?.url?.absoluteString ?? "")\n"
        if let dataBody = request?.httpBody, let strBody = String(bytes: dataBody, encoding: .utf8) {
            
            logStr += "api_request.body = \(strBody)\n"
        }
        
        if let headers = request?.allHTTPHeaderFields {
            var headersStr = "{\n"
            for header in headers {
                headersStr += "   \(header.key) = \(header.value)\n"
            }
            headersStr += "}"
            logStr += "api_request.headers = \(headersStr)\n"
        }
        
        if let httpMethod = request?.httpMethod {
            logStr += "api_request.httpMethod = \(httpMethod)\n"
        }
        
        if let response = response as? HTTPURLResponse {
            let status = response.statusCode
            let headers = response.allHeaderFields
            var headersStr = "{\n"
            for header in headers {
                headersStr += "   \(header.key) = \(header.value)\n"
            }
            headersStr += "}"
            logStr += "api_response.statusCode = \(status)\n"
            logStr += "api_response.headers = \(headersStr)\n"
        }
        
        if let errorStr = error?.localizedDescription {
            logStr += "api_response.error = \(errorStr)\n"
        }
        
        if let responseData = data {
            let responseString = responseData.prettyPrintedJsonString ?? String(data: responseData, encoding: .utf8) ?? "-"
            logStr += "api_response.data = \(responseString)\n"
        } else {
            logStr += "api_response.data = null\n"
        }
        
        if logStr.count > 0 {
            print(logStr)
        }
    }
}
