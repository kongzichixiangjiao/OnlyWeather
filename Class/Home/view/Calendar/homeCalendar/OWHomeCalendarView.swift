//
//  OWCalendar.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class OWHomeCalendarView: UIView {
    
    weak var myDelegate: OWPublicTouchDelegate?
    
    lazy var weakView: OWWeekView = {
        let v = OWWeekView.loadView()
        self.addSubview(v)
        return v
    }()
    
    lazy var collectionView: OWCalendarCollectionView = {
        let c = OWCalendarCollectionView(frame: self.bounds, collectionViewLayout: OWCalendarViewLayout(), isTapGesture: true)
        c.myDelegate = self
        self.addSubview(c)
        return c
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weakView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        CalendarManager.share.currentMonthOffset(tag: 0, handler: {
            [weak self] days, month in
            if let weakSelf = self {
                weakSelf.collectionView.days = days
                weakSelf.collectionView.reloadData()
            }
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
            let space: CGFloat = 1
            let count: Int = 7
            itemSize = CGSize(width: AppWidth / count.ga_CGFloat - (count + 1).ga_CGFloat, height: kOWCalendarCellHeight)
            minimumLineSpacing = space // cell竖直方向距离
            minimumInteritemSpacing = space
            scrollDirection = .vertical // .horizontal
        }
    }
}
