//
//  Month.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class CalendarMonthViewModel: ObservableObject {
    @Published var calendarMonth: CalendarMonth
    
    private let userCal = Calendar.current
    
    private let daysOfMonthArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init () {
        calendarMonth = CalendarMonth(month: userCal.component(.month, from: Date()), year: userCal.component(.year, from: Date()))
    }
    
    init (calendarMonth: CalendarMonth) {
        self.calendarMonth = calendarMonth
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
    
    func nextMonth() -> CalendarMonthViewModel {
        //let nMonth = (calendarMonth.month-1+1)%12+1
        let nMonth = (calendarMonth.month)%12+1
        let next = CalendarMonthViewModel(calendarMonth: CalendarMonth(month: nMonth, year: nMonth == 1 ? calendarMonth.year+1 : calendarMonth.year))
        return next
    }
    
    func prevMonth() -> CalendarMonthViewModel {
        //let pMonth = (calendarMonth.month-1+11)%12+1
        let pMonth = (calendarMonth.month+10)%12+1
        let prev = CalendarMonthViewModel(calendarMonth: CalendarMonth(month: pMonth, year: pMonth == 12 ? calendarMonth.year-1 : calendarMonth.year))
        return prev
    }
    
    func getDaysOfMonth() -> Int {
        if (calendarMonth.month == 2 && calendarMonth.year%4 == 0) {
            return 29
        } else {
            return daysOfMonthArr[calendarMonth.month-1]
        }
    }
    
    func equals(monthViewModel: CalendarMonthViewModel) -> Bool {
        return self.calendarMonth.year == monthViewModel.calendarMonth.year && self.calendarMonth.month == monthViewModel.calendarMonth.month
    }
    
    
}