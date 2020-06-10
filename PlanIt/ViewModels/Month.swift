//
//  Month.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class Month: ObservableObject {
    @Published var currMonth: Int
    @Published var currYear: Int
    private let userCal = Calendar.current
    
    private let daysOfMonthArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init () {
        currMonth = userCal.component(.month, from: Date())
        currYear = userCal.component(.year, from: Date())
    }
    
    init (month: Int, year: Int) {
        currMonth = month
        currYear = year
    }
    
    private func setMonth(month: Int) {
        currMonth = month
    }
    
    private func setYear(year: Int) {
        currYear = year
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
    
    func nextMonth() -> Month {
        let nMonth = (currMonth-1+1)%12+1
        let next = Month(month: currMonth, year: currYear)
        if (nMonth == 1){
            next.setMonth(month: nMonth)
            next.setYear(year: currYear+1)
        } else {
            next.setMonth(month: nMonth)
        }
        return next
    }
    
    func prevMonth() -> Month {
        let pMonth = (currMonth-1+11)%12+1
        let prev = Month(month: currMonth, year: currYear)
        if (pMonth == 12){
            prev.setYear(year: currYear-1)
            prev.setMonth(month: pMonth)
        } else {
            prev.setMonth(month: pMonth)
        }
        return prev
    }
    
    func getDaysOfMonth() -> Int {
        if (currMonth == 2 && currYear%4 == 0) {
            return 29
        } else {
            return daysOfMonthArr[currMonth-1]
        }
    }
    
    func equals(month: Month) -> Bool {
        print(self.currYear == month.currYear && self.currMonth == month.currMonth)
        return self.currYear == month.currYear && self.currMonth == month.currMonth
    }
    
    
}
