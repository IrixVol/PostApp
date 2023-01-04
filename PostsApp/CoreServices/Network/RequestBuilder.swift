//
//  RestRequest.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 31.12.2022.
//

import Foundation

class RequestBuilder {

    public static let baseApiUrl: String = "https://jsonplaceholder.typicode.com"
    
    private var body: Data?
    private var params: [String: Any] = [:]
    private var headers: [String: String] = [:]
    
    private var session: URLSession = URLSession.shared
    private var completionQueue = DispatchQueue.main
    private var httpMethod: HttpMethod = .post
    private var apiMethod: String?
    private var dispatchToMain: Bool = true
    
    var baseApiUrl: String = RequestBuilder.baseApiUrl
    
    func setApiMethod(_ method: String) -> RequestBuilder {
        apiMethod = method
        return self
    }
    
    func setHttpMethod(_ method: HttpMethod) -> RequestBuilder {
        httpMethod = method
        return self
    }
    
    func addParam(key: String, value: Any?) -> RequestBuilder {
        params[key] = value
        return self
    }
    
    func setBody<E: Encodable>(_ data: E) -> RequestBuilder {
        body = try? JSONEncoder().encode(data)
        return self
    }

    func dispatchToMain(_ toMain: Bool) -> RequestBuilder {
        dispatchToMain = toMain
        return self
    }
    
   func build() -> URLRequest? {
        
       let urlString = [baseApiUrl, apiMethod].compactMap { $0 }.joined(separator: "/")

       var components = URLComponents(string: urlString)
       components?.queryItems = params.map { (key, value) in
           URLQueryItem(name: key, value: convert(param: value))
       }

       guard let url = components?.url else {
           assertionFailure("Please setup correct baseUrl, params and method")
           return nil
       }
       
       var request = URLRequest(url: url)
       request.httpMethod = httpMethod.rawValue
       request.timeoutInterval = 5
       request.httpShouldHandleCookies = false
       request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
       request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
       headers.forEach { (key, value) in
           request.setValue(value, forHTTPHeaderField: key)
       }
       
       if let body = body {
           request.httpBody = body
           request.setValue(String(body.count), forHTTPHeaderField: "Content-Length")
       }
       
       return request
    }
    
    @discardableResult
    func execute<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {
        
        guard let request = build() else {
            return nil
        }
        
        let dispatchToMain = dispatchToMain
        let task = session.dataTask(with: request) { data, response, error in
            
            RequestHandler.handle(data: data,
                                  response: response,
                                  error: error,
                                  request: request,
                                  dispatchToMain: dispatchToMain,
                                  completion: completion)
            
        }
        
        task.resume()
        return task
    }
 
    func convert(param: Any) -> String {
        
        switch param {
        case let boolValue as Bool: return "\(boolValue)"
        case let numberValue as NSNumber: return "\(numberValue)"
        case let stringValue as String:
            return stringValue.addingPercentEncoding(withAllowedCharacters: .requestURLParamsAllowed) ?? stringValue
        default:
            assertionFailure("Add handler for type: \(type(of: param))")
            return ""
        }
    }
}

extension CharacterSet {
    
    public static let requestURLParamsAllowed: CharacterSet = {
        
        let symbolsForEscaping = CharacterSet(charactersIn: "\":#[]@!$&'()*+,;=")
        return CharacterSet.urlQueryAllowed.subtracting(symbolsForEscaping)
    }()
}
