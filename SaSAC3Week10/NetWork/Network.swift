//
//  Network.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation
import Alamofire
class Network {
    static let shared = Network()
    
    private init(){ }
    
    func requestConvertible<T: Decodable>(type: T.Type, api: Router, completion: @escaping (Result<T,SeSACError>) -> Void){
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else {return}
                completion(.failure(error))
            }
        }
    }
    
    
    func request<T: Decodable>(type: T.Type, api: SeSacAPI, completion: @escaping (Result<T,SeSACError>) -> Void){
    
        AF.request(api.endPoint, method: api.method,parameters: api.query,encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else {return}
                completion(.failure(error))
            }
        }
    }
}
