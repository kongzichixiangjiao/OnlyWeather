//
//  GACurrentDate.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/9.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import Foundation

class CalendarManager {
    
    static let c: CalendarManager = CalendarManager()
    
    class var share: CalendarManager {
        return c
    }
    
    var currentDay: Int {
        return Date().day
    }
    var currentMonth: Int {
        return Date().month
    }
    var currentYear: Int {
        return Date().year
    }
    
    var currentDate: Date!
    
    /*
     获取当前月 tag = 0
     获取after月 tag -= 1
     获取before月 tag += 1
    */
    public func currentMonthOffset(tag: Int, handler: (_ days: [DayModel], _ month: MonthModel) -> ()) {
        var nearByMonths = nearFebruary(tag: tag)
        var days = [DayModel]()
        
        let afterMonth = nearByMonths.first!
        let currentMonth = nearByMonths[1]
        let beforeMonth = nearByMonths.last!

        // 上一个月天数
        let afterMonthDays: Int = currentMonth.weekDayOfWeek
        // 剩多少天没有满一星期
        let afterWeekDays = (currentMonth.allDays - (7 - afterMonthDays)) % 7
        // 下个月天数
        let beforeMonthDays = 7 - (afterWeekDays != 0 ? afterWeekDays : 7)
        
        // 获取日历第一个星期含有上个月末尾日期
        for i in 0..<afterMonthDays {
            let dayModel = DayModel()
            dayModel.isDayInMonth = false
            dayModel.isDayOfCurrentMonth = false
            dayModel.year = afterMonth.year
            dayModel.month = afterMonth.month
            dayModel.day = (afterMonth.allDays)! - afterMonthDays + i + 1
            days.append(dayModel)
        }
        //获取日历本月的日期  currentMonth
        for i in 0..<currentMonth.allDays {
            let dayModel = DayModel()
            dayModel.isDayInMonth = true
            dayModel.year = currentMonth.year
            dayModel.month = currentMonth.month
            dayModel.day = i + 1
            dayModel.isDayOfCurrentMonth = isCurrentMonthDay(dayModel)
            days.append(dayModel)
        }
        // 获取日历最后一星期含有下个月的日期 beforeMonth 
        for i in 0..<beforeMonthDays {
            let dayModel = DayModel()
            dayModel.isDayInMonth = false
            dayModel.isDayOfCurrentMonth = false
            dayModel.year = beforeMonth.year
            dayModel.month = beforeMonth.month
            dayModel.day = i + 1
            days.append(dayModel)
        }
        handler(days, currentMonth)
    }
    
    // 本月临近两月
    private func nearFebruary(tag: Int) -> [MonthModel]{
        var date = Date()
        var after = Date().dateOfAfterMonth()
        var before = Date().dateOfBeforeMonth()
        
        for _ in 0..<labs(tag) {
            date = tag > 0 ? date.dateOfBeforeMonth() : date.dateOfAfterMonth()
            after = tag > 0 ? date.dateOfAfterMonth() : date.dateOfAfterMonth()
            before = tag > 0 ? date.dateOfBeforeMonth() : date.dateOfBeforeMonth()
        }
        
        currentDate = date
        return [MonthModel(date: after), MonthModel(date: date), MonthModel(date: before)]
    }
    
    private func isCurrentMonthDay(_ day: DayModel) -> Bool {
        if currentDay != day.day || currentMonth != day.month || currentYear != day.year {
            return false
        }
        return true
    }
}

class MonthModel {
    var allDays: Int!
    var weekDayOfWeek: Int!
    var year: Int!
    var month: Int!
    var day: Int!
    
    convenience init(date: Date) {
        self.init()
        self.allDays = date.allDaysOfMonth()
        self.weekDayOfWeek = date.weekDayOfWeekOfEachMonth()
        self.year = date.year
        self.month = date.month
        self.day = date.day
    }
}

class DayModel: MonthModel {
    var isDayOfCurrentMonth: Bool!
    var isDayInMonth: Bool!
}
