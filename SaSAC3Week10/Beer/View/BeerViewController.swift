//
//  BeerViewcontroller.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import UIKit

class BeerViewController: UIViewController{
    
    let viewModel = BeerViewModel()
    
    let mainView = BeerView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        bind()
        
        viewModel.fetchData(type: .getRandom)
    }
    
    private func bind(){
        viewModel.BeerList.bind { data in
            dump(data)
            guard let firstData = data.first else { return }
            self.mainView.titleLabel.text = firstData.name
            if let url = URL(string: firstData.imageURL){
                DispatchQueue.global().async {
                    do{
                        let imageData = try Data(contentsOf: url)
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.mainView.posterView.image = image
                        }
                    }catch{
                        print("데이터 변환 실패 \(error)")
                    }
                }
            }
            self.mainView.contentLabel.text = firstData.description
        }
    }
}
