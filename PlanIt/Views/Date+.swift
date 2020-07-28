//
//  Date+.swift
//  PlanIt
//
//  Created by Helen Wang on 6/23/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

extension Date {
    
    
    func localString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    func isSameDay(_ comparisonDate: Date) -> Bool {
        let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
        return order == .orderedSame
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func begDay() -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        
        if let date = dateFormatterGet.date(from: "\(year)-\(month)-\(day)") {
            return date
        } else {
            print("Date could not be formatted: ")
            print("\(year)-\(month)-\(day)")
           return Date()
        }
    }
    
    func endDay() -> Date {
        let startDay = self.begDay()
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startDay)!
    }
    
}


