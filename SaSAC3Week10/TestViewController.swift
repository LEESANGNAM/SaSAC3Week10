//
//  TestViewController.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/20.
//

import UIKit
import FSCalendar
import SnapKit

class TestViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate{
    fileprivate weak var fsCalendar: FSCalendar!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
        let calendar = FSCalendar(frame: CGRect(x: 20, y: 30, width: 320, height: 400))
        view.backgroundColor = .white
        calendar.scrollDirection = .horizontal
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.scope = .week // 주간 달력 설정
        calendar.dataSource = self
        calendar.delegate = self
         view.addSubview(calendar)
         self.fsCalendar = calendar
        
        
        fsCalendar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
     }
}
