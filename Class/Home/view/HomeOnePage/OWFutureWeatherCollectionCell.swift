//
//  OWFutureWeatherCollectionCell.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/13.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

public let kOWFutureWeatherCollectionCellHeight: CGFloat = 100
public let kOWFutureWeatherCollectionCellWidth: CGFloat = AppWidth / 3
public let kOWFutureWeatherCollectionCell = "OWFutureWeatherCollectionCell"

class OWFutureWeatherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var airQualityLabel: UILabel!
    
    var future: OWFutureWeather! {
        didSet {
            //            weatherImageView
            dateLabel.text = future.date
            weekLabel.text = future.week
            windLabel.text = future.wind
            temperatureLabel.text = future.temperature
        }
    }
    
    var airQuality: OWCityNowAirQuality! {
        didSet {
            airQualityLabel.text = "空气质量：" + airQuality.quality + "  " +  airQuality.AQI
        }
    }
}
