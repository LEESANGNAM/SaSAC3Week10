//
//  Constant.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/22.
//

import UIKit

enum Constant {
    enum Text {
        static let title = UIColor(named: "title")!
    }
    
    enum Image {
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title) // 탭바에 넣었을때 원하는 ui가 안나올경우
    }
    
}
