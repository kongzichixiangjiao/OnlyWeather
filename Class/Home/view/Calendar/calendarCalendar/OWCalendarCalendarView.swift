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
    
    lazy var calendarView: OWHomeCalendarView = {
        let c = OWHomeCalendarView(frame: CGRect.zero)
        c.backgroundColor = UIColor.clear
        self.addSubview(c)
        c.isHiddenCollectionView(true)
        return c
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
        v.frame = CGRect.zero
        return v
    }()
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero)
        t.separatorStyle = .none
        t.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        t.showsVerticalScrollIndicator = true
        t.showsHorizontalScrollIndicator = true
        t.backgroundColor = UIColor.white
        t.delegate = self
        t.dataSource = self
    
        t.tableHeaderView = self.collectionView

        self.insertSubview(t, at: 0)
        
        t.ga.registerNibCell(kOWCanlenderTableViewCell)
        
        return t
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(30)
        }
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(64)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.calendarView.snp.bottom).offset(-44)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
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
                
                let offset = (days.count / 7).ga_CGFloat * kOWCalendarCellHeight
                weakSelf.collectionView.frame = CGRect(x: 0, y: 0, width: AppWidth, height: offset)
                weakSelf.tableView.tableHeaderView = weakSelf.collectionView
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OWCalendarCalendarView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kOWCanlenderTableViewCell) as! OWCanlenderTableViewCell
        cell.textLabel?.text = indexPath.row.ga_str
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.ga.offSetY
        if y > collectionView.ga_h {
            calendarView.isHiddenCollectionView(false)
        } else {
            calendarView.isHiddenCollectionView(true)
        }
    }
}

extension OWCalendarCalendarView: OWPublicSeletecdDelegate {
    func didSelectedAction(tag: Int) {
        print(tag)
        myDelegate?.didSelectedAction(tag: tag)
    }
}
