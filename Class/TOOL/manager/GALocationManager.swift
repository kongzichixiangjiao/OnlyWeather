//
//  GA_LocationManager.swift
//  GA_ALLAMap
//
//  Created by houjianan on 16/8/3.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import Foundation

@objc
protocol GA_LocationManagerDelegate: NSObjectProtocol {
    @objc optional func locatingCompletionAction(_ location: CLLocation?, regeocode: AMapLocationReGeocode?, error: NSError?)
    @objc optional func amapLocation(didUpdateLocation location: CLLocation!)
    @objc optional func amapLocationManager(didChangeAuthorizationStatus status: CLAuthorizationStatus)
}
/// 一次性定位
class GALocationManager: NSObject {
    
    static let l: GALocationManager = GALocationManager()
    
    class var share: GALocationManager {
        return l
    }
    
    fileprivate let kDefaultLocationTimeOut: NSInteger = 8
    fileprivate let kReGeocodeTimeOut: NSInteger = 3
    
    var locationManager: AMapLocationManager?
    var aMapLocatingCompletionHandler: AMapLocatingCompletionBlock?
    weak var myDelegate: GA_LocationManagerDelegate?
    
    override init() {
        super.init()
        initCompleteBlock()
        configLocationManager()
        
    }
    
    func initCompleteBlock() {
        aMapLocatingCompletionHandler = {
            [weak self] location, regeocode, error in
            if let weakSelf = self {
                
                if let location = location {
                    print("location", location)
                }
                if let regeocode = regeocode {
                    print("regeocode", regeocode)
                }
                
                weakSelf.myDelegate?.locatingCompletionAction!(location, regeocode: regeocode, error: error as NSError?)
            }
        }
    }
    
    func configLocationManager() {
        locationManager = AMapLocationManager()
        locationManager?.delegate = self
        // kCLLocationAccuracyBest 越准确越慢 kCLLocationAccuracyBest
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.distanceFilter = 300 // kCLDistanceFilterNone
        locationManager?.locationTimeout = kDefaultLocationTimeOut
        locationManager?.reGeocodeTimeout = kReGeocodeTimeOut
    }
    
    func startUpdating() {
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdating() {
        locationManager?.stopUpdatingLocation()
    }
    
    func cleanUpAction() {
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
    }
    
    func reGeocodeAction() {
        locationActionWith(isReGeocode: true)
    }
    
    func locAction(_ handler: AMapLocatingCompletionBlock) {
        locationActionWith(isReGeocode: false)
    }
    
    func locationActionWith(isReGeocode isRe: Bool) {
        locationManager?.requestLocation(withReGeocode: isRe, completionBlock: aMapLocatingCompletionHandler)
    }
    
}
extension GALocationManager {
    /// 是否开启定位
    var isLocationServicesEnabled: Bool {
        //判断用户定位服务是否开启（指手机的定位）
        if CLLocationManager.locationServicesEnabled() {
            /*
             iOS的应用定位权限有种状态
             1   .NotDetermined 表示用户还未对该应用的定位权限做出选择，但是一般如果用到定位，一进入app的时候就会自动弹出提示框要用户选择启用或者禁止，这个状态应该说进入程序后就不存在了
             2  .Restricted 表示GPS功能受限於某些限制,无法使用定位服务，例如 parental controls(这里没想到该状态的应用场景)该状态用户无法改变
             3  .Denied 表示用户拒绝该应用使用定位服务（也可能是定位服务总开关处于关闭状态,CLLocationManager.authorizationStatus()获取的是应用的授权状态，但是当定位服务总开关处于关闭状态的时候，所有应用的定位服务都为关闭状态 ）
             4  .AuthorizedAlways(iOS 8.0) 表示用户授权该应用可永久使用定位权限
             5  .AuthorizedWhenInUse(iOS 8.0) 表示用户授权该应用或其功能在屏幕上显示时才能访问用户的位置
             */
            /*
             switch CLLocationManager.authorizationStatus() {
             case .denied:
             print("denied")
             break
             case .authorizedAlways:
             print("authorizedAlways")
             break
             case .authorizedWhenInUse:
             print("authorizedWhenInUse")
             break
             case .notDetermined:
             print("notDetermined")
             break
             case .restricted:
             print("restricted")
             break
             }
             print(isLocationServicesEnabledFirstInAPP)
             */
            if CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                return false
            }
            return true
        } else {
            //不能定位用户的位置
            //1.提醒用户检查当前的网络状况
            //2.提醒用户打开定位开关
            return false
        }
    }
    
    /// 是否开启定位
    var isLocationServicesEnabledFirstInAPP: Bool {
        //判断用户定位服务是否开启（指手机的定位）
        if CLLocationManager.locationServicesEnabled() {
            return true
        } else {
            //不能定位用户的位置
            //1.提醒用户检查当前的网络状况
            //2.提醒用户打开定位开关
            return false
        }
    }
}
extension GALocationManager: AMapLocationManagerDelegate {
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print(error)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        myDelegate?.amapLocation?(didUpdateLocation: location)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didExitRegion region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didEnter region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didStartMonitoringFor region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        
        myDelegate?.amapLocationManager?(didChangeAuthorizationStatus: status)
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didDetermineState state: AMapLocationRegionState, for region: AMapLocationRegion!) {
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, monitoringDidFailFor region: AMapLocationRegion!, withError error: Error!) {
        
    }
    
}
