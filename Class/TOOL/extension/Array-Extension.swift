//
//  Array-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation

extension Array {
    
    func ga_getLast(count: Int) -> Array {
        var temp = self
        if temp.count < count {
            return []
        }
        var objs = Array()
        for _ in 0..<count {
            objs.insert(temp.last!, at: 0)
            temp.removeLast()
        }
        return objs
    }
    
    func ga_getFirst(count: Int) -> Array {
        var temp = self
        if temp.count < count {
            return []
        }
        var objs = Array()
        for _ in 0..<count {
            objs.insert(temp.first!, at: 0)
            temp.removeFirst()
        }
        return objs
    }
}
