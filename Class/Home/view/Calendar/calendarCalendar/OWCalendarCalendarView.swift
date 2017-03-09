//
//  OWCalendarCalendarView.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class OWCalendarCalendarView: UIView {
    
    weak var myDelegate: OWPublicSeletecdDelegate?
    
    var days: [DayModel] = []
    var month: MonthModel?
    
    var collectionBackViewHeight: Constraint!
    
    lazy var weakView: OWWeekView = {
        let v = OWWeekView.loadView()
        self.addSubview(v)
        return v
    }()
    
    lazy var headerView: UILabel = {
        let l = UILabel()
        self.addSubview(l)
        return l
    }()
    
    lazy var collectionView: OWPanGestureView = {
        let v = OWPanGestureView(hander: {
            [weak self] tag in
            if let weakSelf = self {
                weakSelf.loadDays(tag: tag)
            }
        })
        v.isUserInteractionEnabled = true
        self.addSubview(v)
        return v
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(30)
        }
        
        weakView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.weakView.snp.bottom)
            make.left.right.equalTo(0)
            self.collectionBackViewHeight = make.height.equalTo(0).constraint
        }
        
        loadDays(tag: 0)
    }
    
    func loadDays(tag: Int) {
        CalendarManager.share.currentMonthOffset(tag: tag, handler: {
            [weak self] days, month in
            if let weakSelf = self {
                weakSelf.month = month
                weakSelf.headerView.text = month.year.ga_str + "年" + month.month.ga_str + "月"
                weakSelf.collectionView.days = days
                weakSelf.collectionView.reloadData()
                
                weakSelf.collectionBackViewHeight.update(offset: (days.count / 7).ga_CGFloat * kOWCalendarCellHeight)
                weakSelf.collectionView.layoutIfNeeded()
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OWCalendarCalendarView: OWPublicSeletecdDelegate {
    func didSelectedAction(tag: Int) {
        print(tag)
        myDelegate?.didSelectedAction(tag: tag)
    }
}
