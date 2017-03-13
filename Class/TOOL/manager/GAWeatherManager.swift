//
//  GAWeatherManager.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//  高德地图 天气搜索

import UIKit

class GAWeatherManager: NSObject {
    
    static let l: GAWeatherManager = GAWeatherManager()
    class var share: GAWeatherManager {
        return l
    }
    
    typealias WeatherSearchHandler = (_ weather: String) -> ()
    var weatherSearchHandler: WeatherSearchHandler!
    var search: AMapSearchAPI!
    
    override init() {
        super.init()
        self.search = AMapSearchAPI()
        self.search.delegate = self
    }
    
    func weather(adcode: String, handler: @escaping WeatherSearchHandler) {
        
        self.weatherSearchHandler = handler
        
        let req:AMapWeatherSearchRequest! = AMapWeatherSearchRequest.init()
        req.city = adcode
        //AMapWeatherType.live为实时天气；AMapWeatherType.forecast为预报天气
        req.type = AMapWeatherType.live
        self.search.aMapWeatherSearch(req)
    }
}

extension GAWeatherManager: AMapSearchDelegate {
    
    func onWeatherSearchDone(_ request: AMapWeatherSearchRequest!, response: AMapWeatherSearchResponse!) {
        //解析response获取天气信息，具体解析见 Demo
        let _ = response.lives.map {
            live in
            print(live.weather)
            weatherSearchHandler(live.weather)
        }
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        print("Error:\(error)")
    }
}
