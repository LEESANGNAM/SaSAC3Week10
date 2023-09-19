//
//  BeerNetwork.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation

enum BeerNetwork {
    
    case getBeers
    case getSingle(id: Int)
    case getRandom
    
    var baseURL: String {
        return "https://api.punkapi.com/v2/"
    }
    
    var endpoint: URL{
        switch self {
        case .getBeers:
            return URL(string: baseURL + "beers")!
        case .getSingle(let id):
            return URL(string: baseURL + "beers/\(id)")!
        case .getRandom:
            return URL(string: baseURL + "beers/random")!
        }
    }
}
