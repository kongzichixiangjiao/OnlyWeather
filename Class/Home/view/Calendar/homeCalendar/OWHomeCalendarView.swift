//
//  OWCalendar.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit
/*
lazy var calendarView: OWHomeCalendarView = {
    let c = OWHomeCalendarView(frame: CGRect.zero)
    c.myDelegate = self
    self.view.addSubview(c)
    return c
}()
 calendarView.snp.makeConstraints { (make) in
    make.top.equalTo(20)
    make.left.right.equalTo(0)
    make.height.equalTo(kOWHomeCalendarViewHeihgt)
 }
*/
public let kOWHomeCalendarViewHeihgt: CGFloat = 64
class OWHomeCalendarView: UIView {
    
    var page: Int = 0
    var days: [Int : [DayModel]] = [0 : []]
    var weather: OWBaseWeather? {
        didSet {
            
        }
    }
    
    weak var myDelegate: OWPublicTouchDelegate?
    var collectionViewTop: Constraint!
    
    lazy var weakView: OWWeekView = {
        let v = OWWeekView.loadView()
        self.addSubview(v)
        return v
    }()
    
    lazy var collectionViewBackView: UIView = {
        let v = UIView()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(OWPanGestureView.pan(sender:)))
        v.addGestureRecognizer(pan)
        self.addSubview(v)
        return v
    }()
    
    lazy var collectionView: OWCalendarCollectionView = {
        let c = OWCalendarCollectionView(frame: self.bounds, collectionViewLayout: OWCalendarViewLayout(), isTapGesture: true)
        c.myDelegate = self
        self.collectionViewBackView.addSubview(c)
        return c
    }()
    
    func pan(sender: UIPanGestureRecognizer) {
        let x = sender.translation(in: sender.view).x
        var isAfter: Bool = true
        if x < -50 {
            isAfter = false
        } else if x > 50 {
            isAfter = true
        }
        if sender.state == .ended {
            if isAfter {
                page -= 1
            } else {
                page += 1
            }
            
            loadDays(tag: page)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weakView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(20)
        }
        collectionViewBackView.snp.makeConstraints({ (make) in
            self.collectionViewTop = make.top.equalTo(20).constraint
            make.left.right.equalTo(0)
            make.height.equalTo(kOWCalendarCellHeight)
        })
        
        collectionView.snp.makeConstraints({ (make) in
            make.edges.equalTo(collectionViewBackView)
        })
        
        loadDays(tag: page)
    }
    
    func loadDays(tag: Int) {
        var newTag = 0
        var group = 0
        if tag >= 0 {
            newTag = tag / 7
            group = tag % 7 + tag / 7 + 1
        }else {
            newTag = -tag / 7 - 1
            group = -(tag % 7 + tag / 7)
        }
        CalendarManager.share.currentMonthOffset(tag: newTag, group: group, handler: {
            [weak self] days, month in
            if let weakSelf = self {
                weakSelf.collectionView.days = days
                weakSelf.collectionView.reloadData()
            }
        })
    }
    
    func isHiddenCollectionView(_ b: Bool) {
        collectionView.isHidden = b
        collectionViewTop.update(offset: b ? 10 : 20)
        UIView.animate(withDuration: 2, animations: {
            self.collectionView.layoutIfNeeded()
            self.collectionView.superview?.layoutIfNeeded()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OWHomeCalendarView: OWPublicTouchDelegate {
    func touchAction() {
        myDelegate?.touchAction()
    }
}

// MARK: GA_SplitScreenLayout
public class OWCalendarViewLayout: UICollectionViewFlowLayout {
    /// 准备布局
    public override func prepare() {
        super.prepare()
        if let _ = collectionView {
            let space: CGFloat = 0
            let count: Int = 7
            itemSize = CGSize(width: AppWidth / count.ga_CGFloat, height: kOWCalendarCellHeight)
            minimumLineSpacing = space // cell竖直方向距离
            minimumInteritemSpacing = space
            scrollDirection = .horizontal // .vertical
        }
    }
}
