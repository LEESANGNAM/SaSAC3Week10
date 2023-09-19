//
//  APIManager.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    private init(){ }
    
    func callrequest<T: Decodable>(type: T.Type,api: BeerNetwork, completion: @escaping (Result<[T],Error>) -> Void) {
        AF.request(api.endpoint).validate().responseDecodable(of:[T].self) { response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
