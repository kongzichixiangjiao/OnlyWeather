//
//  OWHomeTodayView.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

public let kOWHomeTodayWeatherViewHeight: CGFloat = 150

class OWHomeTodayWeatherView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var dressing_indexLabel: UILabel!
    @IBOutlet weak var uv_indexLabel: UILabel!
    @IBOutlet weak var dressing_adviceLabel: UILabel!
    
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var airQuality_indexLabel: UILabel!
    
    class func loadView() -> OWHomeTodayWeatherView {
        return Bundle.main.loadNibNamed("OWHomeTodayWeatherView", owner: self, options: nil)?.last as! OWHomeTodayWeatherView
    }
    
    var weather: OWTodayWeather! {
        didSet {
            dateLabel.text = weather.date_y
            temperatureLabel.text = weather.temperature
//            weatherImageView
            weatherLabel.text = weather.weather
            windLabel.text = weather.wind
            dressing_indexLabel.text = weather.dressing_index
            uv_indexLabel.text = "紫外线强度：" + weather.uv_index
            dressing_adviceLabel.text = "空气质量：" + weather.dressing_advice
        }
    }
    
    var airQuality: OWCityNowAirQuality! {
        didSet {
            airQualityLabel.text = airQuality.quality
            airQuality_indexLabel.text = airQuality.AQI
        }
    }
}
