//
//  MyCalendar.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

public class MyCalendar {
    let userCal = Calendar.current

    /*var currMonth = userCal.component(.month, from: Date())
    var currYear: Int = userCal.component(.year, from: Date())
    var currDay: Int = userCal.component(.day, from: Date())
    var currWeekDay: Int = userCal.component(.weekday, from: Date())
    */
    
    /*func getFirstWeekDay() -> Int {
        var date = DateComponents()
        date.year = currYear
        date.month = currMonth
        date.day = 1
        let firstDate = userCal.date(from: date)
        var unwrapfirstDate: Date = Date()
        if (firstDate != nil) {
            unwrapfirstDate = firstDate!
        } else {
            unwrapfirstDate = Date()
        }
        let firstDay = userCal.component(.weekday, from: unwrapfirstDate)
        //print(firstDay)
        return firstDay%7
    }*/
    
    
}
