//
//  String-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation

extension String {
    //    day_20170316
    var ga_Int: Int {
        if GARegular.match(self, regular: "", regularEnum: .pureNumber) {
            return Int(self)!
        }
        return Int(MAXPRI)
    }
    
    // 20120311 -> 3月11日
    func getMonthDay() -> String {
        let dayIndex = self.index(self.endIndex, offsetBy: -2)
        let day = self.substring(from: dayIndex)
        
        let startRange = self.index(self.startIndex, offsetBy: 4)
        let endRange = self.index(self.startIndex, offsetBy: 6)
        var month = self.substring(with: Range(startRange..<endRange))
        
        if month.substring(to: month.index(month.startIndex, offsetBy: 1)) == "0" {
            month = month.substring(from: month.index(month.startIndex, offsetBy: 1))
        }
        
        return month + "月" + day + "日"
    }
}

// MARK: stringUrl -> URL
extension String {
    var url: URL? {
        if let u = URL(string: self) {
            if self != "" {
                return u
            }
            return nil
        }
        return nil
    }
}

// MARK: 加密
extension String {

    var sha1: String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        //        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
    
    var urlEncode: String! {
        return CFURLCreateStringByAddingPercentEscapes(nil, self as CFString!, nil, "!*'();:@&=+$,/?%#[]" as CFString!, CFStringBuiltInEncodings.UTF8.rawValue)! as String
    }
    
    var localized: String! {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: 颜色 #ffffff ffffff -> UIColor
extension String {
    var color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    func color0X(alpha: CGFloat = 1) -> UIColor {
        var cString:String = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}
