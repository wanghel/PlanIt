//
//  CurrCalendar.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class CurrCalendar: ObservableObject {
    @Published var currMonth: Int
    @Published var currYear: Int
    var currDay: Int
    let userCal = Calendar.current
    
    let daysOfMonthArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init (){
        currMonth = userCal.component(.month, from: Date())
        currYear = userCal.component(.year, from: Date())
        currDay = userCal.component(.day, from: Date())
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
    }
    
    func setYear(year: Int) {
        currYear = year
    }
    
    func setDay(day: Int) {
        currDay = day
    }
    
    func nextMonth() {
        let nMonth = (currMonth-1+1)%12+1
        if (nMonth == 1){
            setMonth(month: nMonth)
            setYear(year: currYear+1)
        } else {
            setMonth(month: nMonth)
        }
    }
    
    func prevMonth() {
        let pMonth = (currMonth-1+11)%12+1
        if (pMonth == 12){
            setYear(year: currYear-1)
            setMonth(month: pMonth)
        } else {
            setMonth(month: pMonth)
        }
    }
    
    func getDaysOfMonth() -> Int {
        if (currMonth == 2 && currYear%4 == 0) {
            return 29
        } else {
            return daysOfMonthArr[currMonth-1]
        }
    }
    
}
