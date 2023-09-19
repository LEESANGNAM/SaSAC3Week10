//
//  ViewController.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. "ZHGh3WaaTf4"
        Network.shared.request(type: PhotoResult.self, api: .detail(id: "ZHGh3WaaTf4")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
//        Network.shared.request(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
        
    }
    
    
   
    
}


struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable{
    let id: String
    let created_at: String
    let urls: PhotoURL
}
struct PhotoURL: Decodable{
    let full: String
    let thumb: String
}

