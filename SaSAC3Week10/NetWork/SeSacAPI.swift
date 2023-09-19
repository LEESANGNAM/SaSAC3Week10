//
//  SeSacAPI.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation
import Alamofire
//enum Router: URLRequestConvertible {
//
//}


enum SeSacAPI {
    private static let key = APIKey.unsplash
    
    case search(query: String)
    case random
    case detail(id: String) //연관값, associated value
    
    private var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endPoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .detail(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(SeSacAPI.key)"]
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
}
