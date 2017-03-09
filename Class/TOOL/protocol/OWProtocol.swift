//
//  OWProtocol.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation


protocol OWPublicTouchDelegate: NSObjectProtocol {
    func touchAction()
}

protocol OWPublicSeletecdDelegate: NSObjectProtocol {
    func didSelectedAction(tag: Int)
}
