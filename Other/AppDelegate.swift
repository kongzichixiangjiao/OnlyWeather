//
//  AppDelegate.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/2.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.red 
        
        registerKey()
        
        return true
    }
    func registerKey() {
        AMapServices.shared().apiKey = theme.AMapKey
    }
    // MARK: - Core Data stack
}

