//
//  Calen.swift
//  PlanIt
//
//  Created by Helen Wang on 5/31/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class Calen: ObservableObject{
    var cDate: Date
    var cMonth: Int
    var cYear: Int
    var cDay: Int
    var cWeekDay: Int
    var isLeapYear: Bool
    let userCal = Calendar.current

    init (){
        cDate = Date()
        cMonth = userCal.component(.month, from: Date())
        cYear = userCal.component(.year, from: Date())
        cDay = userCal.component(.day, from: Date())
        cWeekDay = userCal.component(.weekday, from: Date())
        isLeapYear = cYear % 4 == 0
    }

    /** returns index of weekday the first day falls on in current month */
    func getFirstWeekDay() -> Int {
        var fdate = DateComponents()
        fdate.year = cYear
        fdate.month = cMonth
        fdate.day = 1
        let firstDate = userCal.date(from: fdate)
        var unwrapfirstDate: Date = Date()
        if (firstDate != nil) {
            unwrapfirstDate = firstDate!
        } else {
            unwrapfirstDate = Date()
        }
        let firstDay = userCal.component(.weekday, from: unwrapfirstDate)

        return firstDay%7-1
    }

    func setMonth(month: Int) {
        cMonth = month
        updateWeekDay()
        updateDate()
    }

    func setYear(year: Int) {
        cYear = year
        isLeapYear = cYear % 4 == 0
        updateWeekDay()
        updateDate()
    }

    func setDay(day: Int) {
        cDay = day
        updateWeekDay()
        updateDate()
    }

    func nextMonth() -> Calen {
        setMonth(month: (cMonth+1)%12)
        return self
    }

    func prevMonth() -> Calen {
        setMonth(month: (cMonth+11)%12)
        return self
    }

    private func updateWeekDay() {
        var fdate = DateComponents()
        fdate.year = cYear
        fdate.month = cMonth
        fdate.day = cDay
        let currDate = userCal.date(from: fdate)
        cWeekDay = (userCal.component(.weekday, from: currDate!)-1)%7+1
    }

    private func updateDate() {
        var newDate = DateComponents()
        newDate.year = cYear
        newDate.month = cMonth
        newDate.day = cDay
        cDate = userCal.date(from: newDate)!
    }
    
    func equals(cal: Calen) -> Bool {
        return self.cDay == cal.cDay && self.cMonth == cal.cMonth && self.cYear == cal.cYear
    }
}
