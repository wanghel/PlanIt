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
    
    
}

