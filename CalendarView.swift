//
//  CalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI


var tempDay: Int = 0
/*
struct GridStack<Content: View>: View {
let rows: Int
let columns: Int
let content: (Int, Int) -> Content

var body: some View {
    VStack {
        ForEach(0 ..< rows, id: \.self) { row in
            HStack {
                ForEach(0 ..< self.columns, id: \.self) { column in
                    self.content(row, column)
                }
            }
        }
    }
}*/

struct CalendarView: View {
    var monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "November", "December"]

    var weekDayArr = ["Sun", "Mon", "Tues", "Wed","Thurs", "Fri", "Sat"]
    
    func writeDay(day: Int) -> String {
            tempDay += 1
            print(tempDay)
            return String(tempDay)
    }
    
    var body: some View {
        Text("hi")
        /*VStack {
            /*Text("currMonth is: " + String(currMonth))
            Text("currYear is: " + String(currYear))
            Text("currDay is: " + String(currDay))
            Text("currWeekday is: " + weekDayArr[currWeekDay-1])
            Text("first weekday: " + String(weekDayArr[getFirstWeekDay()-1]))
            */
            
            HStack {
                ForEach(0..<7) { day in
                    Text(weekDayArr[day])
                }
            }
            
            /*GridStack(rows: 5, columns: 7) { row, col in
                Text(String(tempDay))
                Text(writeDay(day: row+col))
            }
            
            /*ForEach(0..<7) { week in
                HStack {
                    ForEach(0..<7) { day in
                        if writeDay(day: day+week) {
                            Text(String(tempDay))
                        } else {
                            ///*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                            Text("hi")
                        }
                        
                    }
                }
            }*/
            */
        }*/
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
