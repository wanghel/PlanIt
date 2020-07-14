//
//  Date+CustomComparison.swift
//  PlanIt
//
//  Created by Helen Wang on 6/23/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

extension Date {
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
    
}

