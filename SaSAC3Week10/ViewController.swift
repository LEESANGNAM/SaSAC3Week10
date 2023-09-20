//
//  ViewController.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBlue
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. "ZHGh3WaaTf4"
        setHierachy()
        setconstraints()
        setUpGesture()
        
        viewModel.request { url in
            self.imageView.kf.setImage(with: url)
        }
        
    }
   private func setUpGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestrue))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGestrue(){
        if scrollView.zoomScale == 1{
            scrollView.setZoomScale(2, animated: true)
        }else{
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
    private func setconstraints(){
        scrollView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    private func setHierachy(){
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
}

extension ViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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

