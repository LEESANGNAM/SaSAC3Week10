//
//  Router.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private static let key = APIKey.unsplash
    
    case search(query: String)
    case random
    case detail(id: String) //연관값, associated value
    
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }

    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .detail(let id):
            return "photos/\(id)"
        }
    }
    
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    var method: HTTPMethod {
        return .get
    }
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .random, .detail:
            return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var requst = URLRequest(url: url)
        requst.headers = header
        requst.method = method
        
        requst = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: requst)
        
        return requst
    }
    
    
}
