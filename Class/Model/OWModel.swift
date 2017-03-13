//
//  OWModel.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

// MARK: 基础数据模型
class OWBaseModel: Mappable {
    var error_code: Int = 99
    var reason: String = ""
    var resultcode: Int = 0
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
    }
}
// MARK: 基础天气数据模型
class OWBaseWeather: OWBaseModel {
    var result: OWWeather!
    
    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        result <- map["result"]
    }
}

class OWWeather: OWBaseModel {
    var today: OWTodayWeather!
    var sk: [String:Any]!
    var future: [String:OWFutureWeather]!
    var futures: [OWFutureWeather] = []
    
    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        future <- map["future"]
        today <- map["today"]
        sk <- map["sk"]
    }
}

class OWSKWeather: OWBaseModel {
    var humidity: String = ""
    var temp: Int = 0
    var time: String = ""
    var wind_direction: String = ""
    var wind_strength: String = ""
    
    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        humidity <- map["humidity"]
        temp <- map["temp"]
        time <- map["time"]
        wind_direction <- map["wind_direction"]
        wind_strength <- map["wind_strength"]
    }
}

class OWFutureWeather: OWBaseModel {
    var day: [String : Any]!
    var date: String = ""
    var temperature: String = ""
    var weather: String = ""
    var weather_id: [String:String] = ["":""]
    var week: String = ""
    var wind: String = ""
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        date <- map["date"]
        date = date.getMonthDay()
        temperature <- map["temperature"]
        weather <- map["weather"]
        weather_id <- map["weather_id"]
        week <- map["week"]
        wind <- map["wind"]
    }
}

class OWTodayWeather: OWBaseModel {
    var city: String = ""
    var comfort_index: String = ""
    var date_y: String = ""
    var dressing_advice: String = ""
    var dressing_index: String = ""
    var drying_index: String = ""
    var exercise_index: String = ""
    var temperature: String = ""
    var travel_index: String = ""
    var uv_index: String = ""
    var wash_index: String = ""
    var weather: String = ""
    var weather_id: [String:String] = ["":""]
    var week: String = ""
    var wind: String = ""
    
    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        city <- map["city"]
        comfort_index <- map["comfort_index"]
        date_y <- map["date_y"]
        dressing_advice <- map["dressing_advice"]
        dressing_index <- map["dressing_index"]
        drying_index <- map["drying_index"]
        exercise_index <- map["exercise_index"]
        temperature <- map["temperature"]
        travel_index <- map["travel_index"]
        uv_index <- map["uv_index"]
        wash_index <- map["wash_index"]
        weather <- map["weather"]
        weather_id <- map["weather_id"]
        week <- map["week"]
        wind <- map["wind"]
    }
}


// MARK: 空气质量

class OWBaseAirQuality: OWBaseModel {
    var result: [OWAirQuality]!
    
    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        result <- map["result"]
    }
}

class OWAirQuality: OWBaseModel {
    var citynow: OWCityNowAirQuality!
    var lastTwoWeeks: [OWCityNowAirQuality]!

    required init?(map: Map){
        super.init(map: map)
    }
    // 解析数据
    override func mapping(map: Map) {
        citynow <- map["citynow"]
        lastTwoWeeks <- map["lastTwoWeeks"]
    }
}

class OWCityNowAirQuality: OWBaseModel {
    var city: String!
    var AQI: String!
    var quality: String!
    var date: String!
    
    var citynow: OWCityNowAirQuality!
    var lastTwoWeeks: [OWCityNowAirQuality]!
    
    required init?(map: Map){
        super.init(map: map)
    }

    override func mapping(map: Map) {
        city <- map["city"]
        AQI <- map["AQI"]
        quality <- map["quality"]
        date <- map["date"]
    }
}

