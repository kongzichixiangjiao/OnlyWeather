//
//  OWHomeCell.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/8.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

public let kOWHomeCell: String = "OWHomeCell"
class OWHomeCell: UITableViewCell {
    
    var homeModel: OWHomeModel? {
        didSet {
            self.todayWeatherView.weather = homeModel?.weather
            self.todayWeatherView.airQuality = homeModel?.airQuality?.citynow
            collectionView.reloadData()
        }
    }
    
    lazy var todayWeatherView: OWHomeTodayWeatherView = {
        let v = OWHomeTodayWeatherView.loadView()
        self.contentView.addSubview(v)
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: self.bounds, collectionViewLayout: OWHomeCellCollectionViewLayout())
        c.isUserInteractionEnabled = true
        c.delegate = self
        c.dataSource = self
        c.bounces = false
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        c.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        c.backgroundColor = UIColor.white
        c.isPagingEnabled = true
        c.ga.registerNibCell(kOWFutureWeatherCollectionCell)
        self.addSubview(c)
        return c
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        todayWeatherView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(20)
            make.height.equalTo(kOWHomeTodayWeatherViewHeight)
            make.width.equalTo(AppWidth)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(todayWeatherView.snp.bottom).offset(10)
            make.height.equalTo(kOWFutureWeatherCollectionCellHeight)
            make.width.equalTo(AppWidth)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension OWHomeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let f = homeModel?.futures {
            return f.count
        }
        return 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kOWFutureWeatherCollectionCell, for: indexPath) as! OWFutureWeatherCollectionCell
        
        cell.future = homeModel?.futures[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: GA_SplitScreenLayout
public class OWHomeCellCollectionViewLayout: UICollectionViewFlowLayout {
    /// 准备布局
    public override func prepare() {
        super.prepare()
        if let _ = collectionView {
            let space: CGFloat = 0
            itemSize = CGSize(width: AppWidth, height: kOWFutureWeatherCollectionCellHeight)
            minimumLineSpacing = space // cell竖直方向距离
            minimumInteritemSpacing = space
            scrollDirection = .horizontal // .vertical
        }
    }
}
