//
//  ViewModel.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/20.
//

import Foundation


final class ViewModel {
    
    func request(completion: @escaping (URL) -> Void) {
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
//                self.imageView.kf.setImage(with: URL(string: success.urls.thumb)!)
                if let url = URL(string: success.urls.thumb){
                    completion(url)
                }
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}
