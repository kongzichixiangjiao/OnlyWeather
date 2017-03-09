//
//  OWCustomeNavigationController.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/2.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class OWCustomeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
        
        guard let systemGes = interactivePopGestureRecognizer else {return}
        guard let gesView = systemGes.view else {return}
        /*
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [Any]
        guard let targetObjc = targets?.first else {return}
        guard let target = (targetObjc as AnyObject).value(forKey: "target") else {return}

        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    
}
