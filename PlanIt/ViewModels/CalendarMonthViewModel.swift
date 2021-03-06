//
//  CalendarMonthViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

//import SwiftUI

class CalendarMonthViewModel: ObservableObject {
    @Published var calendarMonth: CalendarMonth
    
    private let userCal = Calendar.current
    private let daysOfMonthArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init () {
        calendarMonth = CalendarMonth(month: userCal.component(.month, from: Date()), year: userCal.component(.year, from: Date()))
    }
    
    init (date: Date) {
        calendarMonth = CalendarMonth(month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
    }
    
    private func setMonth(month: Int) {
        calendarMonth.month = month
    }
    
    private func setYear(year: Int) {
        calendarMonth.year = year
    }
    
    // returns index of weekday the first day falls on in current month
    func getFirstWeekDay() -> Int {
        var fdate = DateComponents()
        fdate.year = calendarMonth.year
        fdate.month = calendarMonth.month
        fdate.day = 1
        let firstDate = userCal.date(from: fdate)
        var unwrapfirstDate: Date = Date()
        if (firstDate != nil) {
            unwrapfirstDate = firstDate!
        } else {
            unwrapfirstDate = Date()
        }
        let firstDay = userCal.component(.weekday, from: unwrapfirstDate)
        return (firstDay-1)%7
    }
    
    func getDaysOfMonth() -> Int {
        if (calendarMonth.month == 2 && calendarMonth.year%4 == 0) {
            return 29
        } else {
            return daysOfMonthArr[calendarMonth.month-1]
        }
    }
    
    
    func nextMonth() {
        let nMonth = (calendarMonth.month)%12+1
        calendarMonth = CalendarMonth(month: nMonth, year: nMonth == 1 ? calendarMonth.year+1 : calendarMonth.year)
    }
    
    func prevMonth() {
        let pMonth = (calendarMonth.month+10)%12+1
        calendarMonth = CalendarMonth(month: pMonth, year: pMonth == 12 ? calendarMonth.year-1 : calendarMonth.year)
    }
    
    func getDays() -> [[Int]] {
        var days : [[Int]] = Array(repeating: Array(repeating: 0, count: 7), count: 6)
        let firstWeekday = self.getFirstWeekDay()
        let dayOfMonth = self.getDaysOfMonth()
        
        for week in 0...5 {
            for day in 0...6 {
                let currIdx = week*7+day+1
                
                if (currIdx <= firstWeekday || currIdx-firstWeekday > dayOfMonth) {
                    days[week][day] =  -1
                    
                }
                else /*if (todayDay == currIdx-firstWeekday && todayMonth == calendarMonth.month && todayYear == calendarMonth.year) */{
                    days[week][day] =  currIdx-firstWeekday
                }
            }
        }
        
        return days
    }
}
