//
//  OWPanGestureView.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class OWPanGestureView: UIView {

    weak var myDelegate: OWPublicSeletecdDelegate?
    
    var days: [DayModel] = []
    
    var page: Int = 0
    
    typealias Handler = (_ tag: Int) -> ()
    var handler: Handler!
    
    convenience init(hander: @escaping Handler) {
        self.init(frame: CGRect.zero)
        self.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(OWPanGestureView.pan(sender:)))
        self.addGestureRecognizer(pan)
        
        self.handler = hander
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
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
            self.handler(page)
        }
    }

    lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: self.bounds, collectionViewLayout: OWCalendarViewControllerLayout())
        c.isUserInteractionEnabled = true
        c.delegate = self
        c.dataSource = self
        c.bounces = false
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        c.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        c.backgroundColor = UIColor.white
        c.ga.registerNibCell(kOWCalendarCell)
        self.addSubview(c)
        
        return c
    }()
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension OWPanGestureView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kOWCalendarCell, for: indexPath) as! OWCalendarCell
        cell.dayLabel.text = days[indexPath.row].day.ga_str
        cell.monthLabel.text = days[indexPath.row].month.ga_str
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myDelegate?.didSelectedAction(tag: indexPath.row)
    }
}

// MARK: GA_SplitScreenLayout
public class OWCalendarViewControllerLayout: UICollectionViewFlowLayout {
    /// 准备布局
    public override func prepare() {
        super.prepare()
        if let _ = collectionView {
            let space: CGFloat = 0
            let count: CGFloat = 7
            itemSize = CGSize(width: AppWidth / count, height: kOWCalendarCellHeight)
            minimumLineSpacing = space // cell竖直方向距离
            minimumInteritemSpacing = space
            scrollDirection = .vertical // .horizontal
        }
    }
}
