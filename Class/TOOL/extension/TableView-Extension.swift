//
//  TableView-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/8.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

extension GASwift where Base: UITableView {
    
    func registerNibCell(_ name: String) {
        base.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func registerClassCell(_ name: AnyClass) {
        base.register(name, forCellReuseIdentifier: String(describing: name))
    }
}
