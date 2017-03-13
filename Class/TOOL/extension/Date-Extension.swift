//
//  Date-Extension.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation
private let MAX_C: Int = 9999
extension Date {

    var calendar: Calendar {
        get {
            return Calendar.current
        }
    }
    
    var components: DateComponents {
        get {
            let c = self.calendar.dateComponents([.day, .month, .year], from: self)
            return c
        }
    }
    
    var middleDayComponents: DateComponents {
        get {
            var c = components
            c.day = 15
            return  c
        }
    }
    
    var day: Int {
        return components.day! - 1
    }
    
    var month: Int {
        return components.month!
    }
    
    var year: Int {
        return components.year!
    }
    
    func allDaysOfMonth() -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: self) else {
            return MAX_C
        }
        return range.count
    }
    
    // 每个月的第一周的第一天
    func weekDayOfWeekOfEachMonth() -> Int {
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.day = 1 // 从第一天开始
        // 从components中获取第一天
        guard let firstday = calendar.date(from: components) else {
            return MAX_C
        }
        // 从每月的周里面获取周的第一天
        guard let weekDayOfWeek = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: firstday) else {
            return MAX_C
        }
        // 默认每周的第一天序号是1 日历中是0
        return weekDayOfWeek - 1
    }
    
    // 1 -> 2 -> 3 -> 4 向前
    func dateOfBeforeMonth() -> Date {
        var c = middleDayComponents
        if c.month == 1 {
            c.month = 12
            c.year! += 1
        } else {
            c.month! += 1
        }
        return calendar.date(from: c)!
    }
    // 5 -> 4 -> 3 -> 2 向后
    func dateOfAfterMonth() -> Date {
        var c = middleDayComponents
        if c.month == 12 {
            c.month = 1
            c.year! -= 1
        } else {
            c.month! -= 1
        }
        return calendar.date(from: c)!
    }
    
    // 获取currentDate之后的七天（包括currentDate）
    func sevenDay(_ currentDate: Date) -> [Date] {
        print(currentDate)
        var sevenDays: [Date] = []
        sevenDays.append(currentDate)
        let currentMonth = MonthModel(date: currentDate)
        let day = currentMonth.day
        let allDays = currentMonth.allDays
        /*
        let month = currentMonth.month
        
        let beforMonthModel = MonthModel(date: currentDate.dateOfBeforeMonth())
        let beforDay = beforMonthModel.day
        let beforAllDays = beforMonthModel.allDays
        let beforMonth = beforMonthModel.month
        */
        print(day)
        for i in 2...7 {
            let d = day! + i
            print(d, i)
            if d == allDays {
                sevenDays.append(getDate(day: d, date: currentDate.dateOfBeforeMonth())!)
            } else {
                sevenDays.append(getDate(day: d, date: currentDate)!)
            }
        }
        return sevenDays
    }
    // 获取currentDate之后的七天（包括currentDate）的DayModel
    func getSevenDateModles(_ currentDate: Date) -> [DayModel] {
        var sevenDays: [DayModel] = []
        for date in sevenDay(currentDate) {
            sevenDays.append(DayModel(date: date))
        }
        return sevenDays
    }
    // 获取当前月的第几天的日期
    func getDate(day: Int, date: Date) -> Date? {
        if day > date.allDaysOfMonth() {return nil}
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.day = day
        // 从components中获取第day天
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        return date
    }
}

extension Date {
    //001
    func getNowDateFromatDate(_ anyDate: Date) -> Date {
        //设置源日期时区
        let sourceTimeZone = TimeZone(abbreviation: "GMT")
        //设置转换后的目标日期时区
        let destinationTimeZone = TimeZone.autoupdatingCurrent
        //得到源日期与世界标准时间的偏移量
        let sourceGMTOffset = sourceTimeZone!.secondsFromGMT(for: anyDate)
        //目标日期与本地时区的偏移量
        let destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: anyDate)
        //得到时间偏移量的差值
        let interval = destinationGMTOffset - sourceGMTOffset
        //转为现在时间
        let destinationDateNow = Date(timeInterval: TimeInterval(interval), since: anyDate)
        return destinationDateNow;
    }
    // 002
    var currentDate: Date {
        get {
            let timeZoneOffset = TimeInterval(NSTimeZone.system.secondsFromGMT())
            let date = self.addingTimeInterval(timeZoneOffset)
            return date
        }
    }
    
    func getDateString(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        dateformatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateStr = dateformatter.string(from: date)
        return dateStr
    }
    
    func getCurrentDateString(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        dateformatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateStr = dateformatter.string(from: self)
        return dateStr
    }
    
    func getDate(dateStr: String, dateFormat: String = "yyyy-mm-dd HH-mm-ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")

        guard let d = dateFormatter.date(from: dateStr) else {
            return nil
        }
        
        return d
    }
}
