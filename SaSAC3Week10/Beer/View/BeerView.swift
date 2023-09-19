//
//  BeerView.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/20.
//

import UIKit
import SnapKit

class BeerView: UIView {
    let titleLabel = {
       let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textAlignment = .center
        view.numberOfLines = 1
        return view
    }()
    
    let posterView = {
        let view = UIImageView()
        return view
    }()
    
    let contentLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setAddElement()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddElement(){
        addSubview(titleLabel)
        addSubview(posterView)
        addSubview(contentLabel)
    }
    
    func setConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(40)
        }
        posterView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(posterView.snp.width).multipliedBy(2)
        }
        contentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(posterView.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        
    }
    
    
    
}
