//
//  CalendarWeekViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 7/15/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class CalendarWeekViewModel: ObservableObject {
    @Published var calendarWeek: CalendarWeek
    @Published var week = [Int]()
    
    var date: Date
    private let userCal = Calendar.current
    private let daysOfMonthArr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init() {
        self.date = Date()
        calendarWeek = CalendarWeek(day: userCal.component(.day, from: Date()), month: userCal.component(.month, from: Date()), year: userCal.component(.year, from: Date()))
        week = loadWeek()
    }
    
    init(date: Date) {
        self.date = date
        calendarWeek = CalendarWeek(day: userCal.component(.day, from: date), month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
        week = loadWeek()
    }
    
    func loadWeek() -> [Int] {
        let userCal = Calendar.current
        var arr = Array(repeating: 0, count: 7)
        
        let weekday = userCal.component(.weekday, from: date)
        
        var calendarWeekPointer = CalendarWeek(day: userCal.component(.day, from: date), month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
        
        arr[weekday-1] = calendarWeekPointer.day
        if weekday-2 >= 0 {
            for day in (0..<(weekday-1)).reversed() {
                calendarWeekPointer = getPrevDay(week: calendarWeekPointer)
                arr[day] = calendarWeekPointer.day
            }
        }
        
        calendarWeekPointer = CalendarWeek(day: userCal.component(.day, from: date), month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
        
        if weekday <= 6 {
            for day in weekday...6 {
                calendarWeekPointer = getNextDay(week: calendarWeekPointer)
                arr[day] = calendarWeekPointer.day
            }
        }
    
        return arr
    }
    
    
    
    func getPrevDay(week: CalendarWeek) -> CalendarWeek {
        if week.day-1 <= 0 {
            let calendarWeek: CalendarWeek
            if week.month == 1 {
                calendarWeek = CalendarWeek(day: daysOfMonthArr[(week.month+10)%12], month: (week.month+10)%12+1, year: week.year-1)
            } else  if (week.month+10)%12+1 == 2 && week.year % 4 == 0 {
                calendarWeek = CalendarWeek(day: daysOfMonthArr[(week.month+10)%12]-1, month: (week.month+10)%12+1, year: week.year)
            } else {
                calendarWeek = CalendarWeek(day: daysOfMonthArr[(week.month+10)%12], month: (week.month+10)%12+1, year: week.year)
            }
            return calendarWeek
        } else {
            return CalendarWeek(day: week.day-1, month: week.month, year: week.year)
        }
    }
    
    func getNextDay(week: CalendarWeek) -> CalendarWeek {
        if week.month == 2 && week.year % 4 == 0 && week.day == 28 {
            return CalendarWeek(day: week.day+1, month: week.month, year: week.year)
        }
        if week.day+1 > daysOfMonthArr[week.month-1] {
            let calendarWeek: CalendarWeek
            if week.month == 12 {
                calendarWeek = CalendarWeek(day: 1, month: (week.month)%12, year: week.year+1)
            } else {
                calendarWeek = CalendarWeek(day: 1, month: (week.month)%12, year: week.year)
            }
            return calendarWeek
        } else {
            return CalendarWeek(day: week.day+1, month: week.month, year: week.year)
        }
    }
    
    func getPrevWeek() {
        self.date = date.addingTimeInterval(-604800)
        calendarWeek = CalendarWeek(day: userCal.component(.day, from: date), month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
        week = loadWeek()
    }
    
    func getNextWeek() {
        self.date = date.addingTimeInterval(604800)
        calendarWeek = CalendarWeek(day: userCal.component(.day, from: date), month: userCal.component(.month, from: date), year: userCal.component(.year, from: date))
        week = loadWeek()
    }
    
}
