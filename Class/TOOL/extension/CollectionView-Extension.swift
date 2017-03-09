//
//  CollectionView-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

extension GASwift where Base: UICollectionView {
    
    func registerNibCell(_ name: String) {
        base.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
    
    func registerClassCell(_ name: String) {
        base.register(NSClassFromString(name), forCellWithReuseIdentifier: name)
    }
}
