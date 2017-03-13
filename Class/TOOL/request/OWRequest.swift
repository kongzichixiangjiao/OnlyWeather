//
//  OWRequest.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class OWRequest {
    static let r: OWRequest = OWRequest()
    
    class var share: OWRequest {
        return r
    }
    //    , handler: @escaping (_ value: DataResponse<Any>) -> ()
    public func getRequest(url: String, parameters: [String:Any]) {
        request(url, parameters: parameters).responseJSON { (response) in
            print(response.result.value)
            print(response)
            print(response.result)
            print(response.description)
        }
    }
}

class OWRequestWeather {
    
    static let r: OWRequestWeather = OWRequestWeather()
    
    class var share: OWRequestWeather {
        return r
    }
    
    public func requestWeather(url: String, parameters: [String:Any], hadler: @escaping (_ weather: OWBaseWeather?, _ success: Bool, _ message: String) -> ()) {
        request(url, parameters: parameters).responseObject { (response: DataResponse<OWBaseWeather>) in
            
            if let weather = response.result.value {
                for day in Date().getSevenDateModles(Date().currentDate) {
                    var monthStr = day.month.ga_str
                    var dayStr = day.day.ga_str
                    if day.month.ga_str.characters.count == 1 {
                        monthStr = "0" + day.month.ga_str
                    }
                    if day.day.ga_str.characters.count == 1 {
                        dayStr = "0" + day.day.ga_str
                    }
                    let key = "day_" + day.year.ga_str + monthStr + dayStr
                    weather.result.futures.append((weather.result.future[key])!)
                }
                hadler(weather, true, "ok")
                return
            }
            hadler(nil, false, "error")
        }
    }
    
    public func requestAirQualyity(url: String, parameters: [String:Any], handler: @escaping (_ airQualyity: OWAirQuality?, _ success: Bool, _ message: String) -> ()) {
        request(url, parameters: parameters).responseObject { (response: DataResponse<OWBaseAirQuality>) in
            if let airQualyity = response.result.value {
                handler(airQualyity.result.first, true, "ok")
                return
            }
            handler(nil, false, "error")
        }
    }
    
    public func requestConstellation(url: String, parameters: [String:Any], handler: @escaping (_ airQualyity: OWAirQuality?, _ success: Bool, _ message: String) -> ()) {
        request(url, parameters: parameters).responseObject { (response: DataResponse<OWBaseAirQuality>) in
            if let airQualyity = response.result.value {
                handler(airQualyity.result.first, true, "ok")
                return
            }
            handler(nil, false, "error")
        }
    }
    
    
}
