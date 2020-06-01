//
//  CurrCalendar.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class CurrCalendar: ObservableObject {
    var currDate: Date
    @Published var currMonth: Int
    var currYear: Int
    var currDay: Int
    var currWeekDay: Int
    var isLeapYear: Bool
    let userCal = Calendar.current
    
    init (){
        currDate = Date()
        currMonth = userCal.component(.month, from: Date())
        currYear = userCal.component(.year, from: Date())
        currDay = userCal.component(.day, from: Date())
        currWeekDay = userCal.component(.weekday, from: Date())
        isLeapYear = currYear % 4 == 0
    }
    
    /** returns index of weekday the first day falls on in current month */
    func getFirstWeekDay() -> Int {
        var fdate = DateComponents()
        fdate.year = currYear
        fdate.month = currMonth
        fdate.day = 1
        let firstDate = userCal.date(from: fdate)
        var unwrapfirstDate: Date = Date()
        if (firstDate != nil) {
            unwrapfirstDate = firstDate!
        } else {
            unwrapfirstDate = Date()
        }
        let firstDay = userCal.component(.weekday, from: unwrapfirstDate)
        //print(firstDay)
        return (firstDay-1)%7
    }
    
    func setMonth(month: Int) {
        currMonth = month
        updateWeekDay()
        updateDate()
    }
    
    func setYear(year: Int) {
        currYear = year
        isLeapYear = currYear % 4 == 0
        updateWeekDay()
        updateDate()
    }
    
    func setDay(day: Int) {
        currDay = day
        updateWeekDay()
        updateDate()
    }
    
    func nextMonth() {
        let nMonth = (currMonth+1)%12
        if (nMonth == 0){
            setMonth(month: nMonth)
            setYear(year: currYear+1)
            print("after change")
        } else {
            setMonth(month: nMonth)
        }
    }
    
    func prevMonth() {
        let pMonth = (currMonth+11)%12
        if (pMonth == 11){
            setMonth(month: pMonth)
            setYear(year: currYear-1)
            print("after change")
        } else {
            setMonth(month: pMonth)
        }
    }
    
    private func updateWeekDay() {
        var fdate = DateComponents()
        fdate.year = currYear
        fdate.month = currMonth
        fdate.day = currDay
        let currDate = userCal.date(from: fdate)
        currWeekDay = (userCal.component(.weekday, from: currDate!)-1)%7+1
    }
    
    private func updateDate() {
        var newDate = DateComponents()
        newDate.year = currYear
        newDate.month = currMonth
        newDate.day = currDay
        currDate = userCal.date(from: newDate)!
    }
    
}
