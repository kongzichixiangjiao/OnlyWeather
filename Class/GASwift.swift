//
//  GASwift.swift
//
//  Created by houjianan on 2017/3/8.
//  Copyright © 2017年 houjianan. All rights reserved.
//

// 定义泛型结构体
public struct GASwift<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol GASwiftCompatible {
    // 协议中不能使用泛型 只能用 associatedtype
    associatedtype CompatibleType
    // 定义两个属性
    static var ga: GASwift<CompatibleType>.Type { get set }
    var ga: GASwift<CompatibleType> { get set }
}

public extension GASwiftCompatible {
    // extesnion中实现两个属性
    public static var ga: GASwift<Self>.Type {
        get {
            return GASwift<Self>.self
        }
        set {
            
        }
    }
    
    public var ga: GASwift<Self> {
        get {
            return GASwift(self)
        }
        set {
            
        }
    }
}

import Foundation
import UIKit
// NSObject 遵守协议 GASwiftCompatible
extension NSObject: GASwiftCompatible {

}


// MARK: eg
extension GASwift where Base: UIView {
    func add() {
        print(2)
    }
}

// 调用add()
    // UIView().ga.add()
