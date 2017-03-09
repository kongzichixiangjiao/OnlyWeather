//
//  OWCanlendarViewController.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class OWCanlendarViewController: UIViewController {

    lazy var canlendarView: OWCalendarCalendarView = {
        let c = OWCalendarCalendarView(frame: CGRect.zero)
        self.view.addSubview(c)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.white
        
        canlendarView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

}
