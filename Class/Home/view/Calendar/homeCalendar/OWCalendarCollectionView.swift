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
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(OWCalendarCollectionView.pan(sender:)))
        self.addGestureRecognizer(pan)
        
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
    
    func pan(sender: UIPanGestureRecognizer) {
        let x = sender.translation(in: sender.view).x
        if x < -50 {
            if index < 4 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentOffset = CGPoint(x: (self.index + 1).ga_CGFloat * AppWidth, y: 0)
                    
                })
            }
        } else if x > 50 {
            if index > 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    print(self.index)
                    self.contentOffset = CGPoint(x: (self.index - 1).ga_CGFloat * AppWidth, y: 0)
                })
            }
        }
        
        if sender.state == UIGestureRecognizerState.ended {
            index = Int(self.contentOffset.x / AppWidth)
        }
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
