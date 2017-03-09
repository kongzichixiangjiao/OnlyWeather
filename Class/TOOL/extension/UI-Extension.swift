//
//  GA_UIExtension.swift
//  GA_LoginScrollViewController
//
//  Created by houjianan on 2016/11/21.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

extension UILabel {

}

extension UIView {
    func ga_show() {
//        print("--", self, "--")
    }
    
    // color 
    func ga_backColor(color: UIColor = UIColor.orange) {
        self.backgroundColor = color
    }

    func ga_clear() {
        self.backgroundColor = UIColor.clear
    }
    // frame
    func ga_rect(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.frame = CGRect(x: x, y: y, width: w, height: h)
    }
    
    var ga_w: CGFloat {
        return self.frame.size.width
    }
    var ga_h: CGFloat {
        return self.frame.size.height
    }
    var ga_x: CGFloat {
        return self.frame.origin.x
    }
    var ga_y: CGFloat {
        return self.frame.origin.y
    }
    var ga_maxX: CGFloat {
        return self.ga_x + self.ga_w
    }
    var ga_maxY: CGFloat {
        return self.ga_y + self.ga_h
    }
    var ga_centerY: CGFloat {
        return self.ga_maxY - self.ga_h / 2
    }
    var ga_centerX: CGFloat {
        return self.ga_maxX - self.ga_w / 2
    }

}

extension UIButton {
    func ga_setNormal(title: String, titleColor: UIColor, fontSize: CGFloat) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    func ga_setSelected(title: String, titleColor: UIColor) {
        self.setTitle(title, for: .selected)
        self.setTitleColor(titleColor, for: .selected)
    }
    func ga_set(imageNormalNamed: String = "", imageSelectedNamed: String = "") {
        if imageNormalNamed != "" {
            self.setImage(UIImage(named: imageNormalNamed), for: .normal)
        }
        if imageSelectedNamed != "" {
            self.setImage(UIImage(named: imageSelectedNamed), for: .selected)
        }
    }
    func ga_setBack(imageNormalNamed: String = "", imageSelectedNamed: String = "", title: String = "") {
        if imageNormalNamed != "" {
            self.setBackgroundImage(UIImage(named: imageNormalNamed), for: .normal)
        }
        if imageSelectedNamed != "" {
            self.setBackgroundImage(UIImage(named: imageSelectedNamed), for: .selected)
        }
    }
    
    func ga_setBack(imageNormalNamed: String = "", imageDisabledNamed: String = "", title: String = "") {
        if imageNormalNamed != "" {
            self.setBackgroundImage(UIImage(named: imageNormalNamed), for: .normal)
        }
        if imageDisabledNamed != "" {
            self.setBackgroundImage(UIImage(named: imageDisabledNamed), for: .disabled)
        }
    }
    
}

extension UIImage {
    var ga_getSize: CGSize {
        return self.size
    }
    
    var ga_getW: CGFloat {
        return self.size.width
    }

    var ga_getH: CGFloat {
        return self.size.height
    }
}

extension GASwift where Base: UIScrollView {
    var offSetX: CGFloat {
        return base.contentOffset.x
    }
    var offSetY: CGFloat {
        return base.contentOffset.y
    }
}
