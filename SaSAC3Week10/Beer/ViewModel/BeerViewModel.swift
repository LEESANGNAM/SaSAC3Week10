//
//  BeerViewModel.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation

class BeerViewModel {
    var BeerList = Observer<[Beer]>([])
    
    func fetchData(type: BeerNetwork){
        APIManager.shared.callrequest(type: Beer.self, api: type) { response in
            switch response {
            case .success(let success):
                self.BeerList.value = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
