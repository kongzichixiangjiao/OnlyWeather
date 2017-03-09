//
//  OWTestViewController.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/2.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class OWTestViewController: OWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class 侯佳男 {
    var gender: String = "男"
    var birthday: String = "1986.12.30"
    var workYears: Int = 4
    var cell_phoneNumber: String = "13146218617"
    var E_mail = "58895347@qq.com"
}

class PersonalAccount {
    var evernote: String = "houjianan_110@163.com"
    var github: String = "kongzichixiangjiao"
}

class WorkExperience: NSObject {
    
    var startDate: String!
    var endDate: String!
    var companyName: String!
    var position: String!
    var responsibilities: [String] = []
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
}
/*
var workExperiences: [[String : Any]] = [["startDate" : "2011/08",
                                          "endDate" : "2013/3",
                                          "companyName" : "北京沁木春服装有限公司",
                                          "position" : "web前端开发",
                                          "responsibilities" : ["1、网页设计",
                                                                "2、网页切图",
                                                                "3、网页开发"]],
                                         ["startDate" : "2013/6",
                                          "endDate" : "2014/11",
                                          "companyName" : "北京金凯科技有限公司",
                                          "position" : "iOS开发工程师",
                                          "responsibilities" : ["1、完成公司iOS软件应用的开发",
                                                                "2、根据产品需求完成架构和模块设计、开发工作",
                                                                "3、及时处理、协调和解决项目进程中的问题，保证项目按计划进行",
                                                                "4、追踪前沿技术的发展，结合实际应用需求进行技术的改进与创新",
                                                                "5、能按照项目计划，按时提交高质量的代码，完成开发任务",
                                                                "6、改善软件的易用性，提升用户使用体验",
                                                                "7、负责移动平台新技术研究、功能扩展，现有开发方法的改进"]],
                                         ["startDate" : "2014/12",
                                          "endDate" : "--",
                                          "companyName" : "位聚科技（北京）有限公司",
                                          "position" : "iOS开发工程师",
                                          "responsibilities" : ["1、负责iOS客户端app的设计与开发",
                                                                "2、参与产品需求的沟通、讨论和协调",
                                                                "3、保证代码质量",
                                                                "4、技术点调研、研究和学习",
                                                                "5、自我技术提升"]],
                                         ["startDate" : "2015/6",
                                          "endDate" : "2015-10",
                                          "companyName" : "--",
                                          "position" : "iOS讲师",
                                          "responsibilities" : ["1、技术点讲解",
                                                                "2、答疑解惑"]]]]

*/
