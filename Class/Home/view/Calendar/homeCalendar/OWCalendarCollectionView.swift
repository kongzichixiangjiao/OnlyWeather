//
//  OWCalendarCollectionView.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class OWCalendarCollectionView: UICollectionView {

    weak var myDelegate: OWPublicTouchDelegate?
    
    var days: [DayModel] = []
    var index: Int = 0
    
    convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, isTapGesture: Bool) {
        self.init(frame: frame, collectionViewLayout: layout)
        
        isUserInteractionEnabled = true
        delegate = self
        dataSource = self
        bounces = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
        contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        backgroundColor = UIColor.white
        
        ga.registerNibCell(kOWCalendarCell)
        
        if isTapGesture {
            let tap = UITapGestureRecognizer(target: self, action: #selector(OWCalendarCollectionView.tap(sender:)))
            self.addGestureRecognizer(tap)
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    func tap(sender: UITapGestureRecognizer) {
        myDelegate?.touchAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OWCalendarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kOWCalendarCell, for: indexPath) as! OWCalendarCell
        cell.dayLabel.text = String(days[indexPath.row].day)
        cell.monthLabel.text = String(days[indexPath.row].month)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
