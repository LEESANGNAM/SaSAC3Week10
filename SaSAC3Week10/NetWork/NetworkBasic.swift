//
//  NetworkBasic.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACError: Int,Error {
    case unauthorized = 401
    case permisstionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증 정보가 없습니다."
        case .permisstionDenied:
            return "권한이 없습니다."
        case .invalidServer:
            return "서버 점검 중입니다."
        case .missingParameter:
            return "검색어를 입력해주세요."
        }
    }
}



final class NetWorkBasic {
    
    static let shared = NetWorkBasic()
    
    private init() { }
    
    func request(api: SeSacAPI, query: String, completion: @escaping (Result<Photo,SeSACError>) -> Void){
    
        AF.request(api.endPoint, method: api.method,parameters: api.query,encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: Photo.self) { response in
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
    func random(api: SeSacAPI, completion: @escaping (Result<PhotoResult,SeSACError>) -> Void){
        AF.request(api.endPoint, method: api.method,headers: api.header).responseDecodable(of: PhotoResult.self) { response in
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
    func detailPhoto(api: SeSacAPI, id: String,completion: @escaping (Result<PhotoResult,SeSACError>) -> Void ){
    
        AF.request(api.endPoint, method: api.method,headers: api.header).responseDecodable(of: PhotoResult.self) { response in
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
