//
//  GARegular.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation

enum Regular: String {
    //用户名验证（允许使用小写字母、数字、下滑线、横杠，一共3~16个字符）
    case userName = "^[a-z0-9_-]{3,16}$",
    eMail = "^([a-z0-9_.-]+)@([da-z.-]+).([a-z.]{2,6})$",
    phone = "^1[0-9]{10}$",
    url = "^(https?://)?([da-z.-]+).([a-z.]{2,6})([/w.-]*)*/?$",
    ip = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    html = "^<([a-z]+)([^<]+)*(?:>(.*)</1>|s+/>)$",
    pureNumber = "^[0-9]*$",
    none = ""
}

class GARegular {
    class func match(_ input: String, regular: String = "", regularEnum: Regular = .none) -> Bool {
        
        let regular = regularEnum == .none ? regular : regularEnum.rawValue
        
        let regex = try? NSRegularExpression(pattern: regular, options: .caseInsensitive)
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}
