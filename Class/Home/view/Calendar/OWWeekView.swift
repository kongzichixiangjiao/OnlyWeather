//
//  OWWeekView.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class OWWeekView: UIView {
   
    class func loadView() -> OWWeekView {
        return Bundle.main.loadNibNamed("OWWeekView", owner: self, options: nil)?.last as! OWWeekView
    }

}
