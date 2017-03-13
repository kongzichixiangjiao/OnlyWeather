//
//  OWHomeViewController.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/2.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class OWHomeModel {
    var weather: OWTodayWeather?
    var airQuality: OWAirQuality?
    var futures: [OWFutureWeather] = []
}

class OWHomeViewController: OWBaseViewController {
    
    @IBOutlet weak var dressLabel: UILabel!
    
    var homeModel: OWHomeModel = OWHomeModel()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.ga.registerNibCell(kOWHomeCell)
        t.ga.registerNibCell(kOWConstellationTableViewCell)
        
        t.separatorStyle = .none
        t.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = UIColor.clear
        t.showsHorizontalScrollIndicator = false
        t.delegate = self
        t.dataSource = self
        t.isPagingEnabled = true
        
        self.view.addSubview(t)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = "f0f0f0".color0X
        
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        GALocationManager.l.startUpdating()
        
        requestData()
    }
    
    @IBAction func tapDressLabel(_ sender: UITapGestureRecognizer) {
        print("选择地点")
    }
}

// MARK: 数据请求
extension OWHomeViewController {
    func requestData() {
        requestWeatherData()
        requestConstellationData()
    }
    
    func requestConstellationData() {
        let p = ["consName":"白羊座", "key":theme.RequestConstellationKey, "type" : "today"]
        OWRequestWeather.share.requestConstellation(url: API.constellation, parameters: p, hadler: {
            [weak self] d, b, m in
            if let weakSelf = self {
                if b {

                }
            }
        })
    }
    
    func requestWeatherData() {
        
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        
        group.enter()
        queue.async(group: group, execute: {
            self.requestWeather(over: {
                group.leave()
            })
        })
        
        group.enter()
        queue.async(group: group, execute: {
            self.requestAirQuality(over: {
                group.leave()
            })
        })
        
        group.notify(queue: queue, execute: {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .left)
            }
        })
    }
    
    func requestWeather(over: @escaping () -> ()) {
        let p = ["cityname":"北京", "key":theme.RequestWeatherKey]
        OWRequestWeather.share.requestWeather(url: API.weather, parameters: p, hadler: {
            [weak self] d, b, m in
            if let weakSelf = self {
                if b {
                    weakSelf.homeModel.weather = d?.result.today
                    weakSelf.homeModel.futures = (d?.result.futures)!
                }
                over()
            }
        })
    }
    
    func requestAirQuality(over: @escaping () -> ()) {
        let p = ["city":"北京", "key":theme.RequestAirQualityKey]
        OWRequestWeather.share.requestAirQualyity(url: API.airQuality, parameters: p, handler: {
            [weak self] d, b, m in
            if let weakSelf = self {
                if b {
                   weakSelf.homeModel.airQuality = d
                }
                over()
            }
        })
    }
}


extension OWHomeViewController: OWPublicTouchDelegate {
    func touchAction() {
        let vc = OWCanlendarViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension OWHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kOWConstellationTableViewCell) as! OWConstellationTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kOWHomeCell) as! OWHomeCell
            if let _ =  homeModel.weather {
                cell.homeModel = homeModel
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? AppHeight * 2 : AppHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("天气详情页")
        default:
            print("default")
        }
    }
}
