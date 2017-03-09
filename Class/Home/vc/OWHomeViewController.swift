//
//  OWHomeViewController.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/2.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class OWHomeViewController: OWBaseViewController {

    lazy var calendarView: OWHomeCalendarView = {
        let c = OWHomeCalendarView(frame: CGRect.zero)
        c.myDelegate = self 
        self.view.addSubview(c)
        return c
    }()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.ga.registerNibCell(kOWHomeCell)
        t.ga.registerNibCell(kOWConstellationTableViewCell)
        
        t.separatorStyle = .none
        t.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = UIColor.white
        t.showsHorizontalScrollIndicator = false
        t.delegate = self
        t.dataSource = self
        t.isPagingEnabled = true

        self.view.addSubview(t)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.height.equalTo(64)
        }

    }

}

extension OWHomeViewController: OWPublicTouchDelegate {
    func touchAction() {
        let vc = OWCanlendarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension OWHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kOWConstellationTableViewCell) as! OWConstellationTableViewCell
                        cell.backgroundColor = UIColor.orange
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kOWHomeCell) as! OWHomeCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? AppHeight * 2 : AppHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("天气详情页")
        default:
            print("default")
        }
    }
}
