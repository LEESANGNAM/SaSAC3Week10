//
//  Observer.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation

class Observer<T>{
    var listener: ((T) -> Void)?
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    init(_ value: T){
        self.value = value
    }
    
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
    
}
