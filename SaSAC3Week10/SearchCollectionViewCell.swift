//
//  SearchCell.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure(){
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .systemBlue
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.text = "테스트ads"
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
