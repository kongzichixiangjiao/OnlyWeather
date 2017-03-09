//
//  Int-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var ga_str: String {
        return String(self)
    }
    
    var ga_CGFloat: CGFloat {
        return CGFloat(self)
    }
}

extension Float {
    var ga_str: String {
        return String(self)
    }
}

extension Double {
    var ga_str: String {
        return String(self)
    }
}

extension CGFloat {
    var ga_half: CGFloat {
        return self / 2
    }
    
    func ga_half(other: CGFloat) -> CGFloat {
        return self / 2 - other / 2
    }
    var ga_RectZero: CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    var ga_Int: Int {
        return Int(self)
    }
}
