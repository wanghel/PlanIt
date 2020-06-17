//
//  MonthView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/31/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct MonthView: View {
    @EnvironmentObject var viewControl: ViewControl
    
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    let weekDayArr = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
    let todayDay: Int = Calendar.current.component(.day, from: Date())
    let todayMonth = Calendar.current.component(.month, from: Date())
    let todayYear = Calendar.current.component(.year, from: Date())
    
    var calendar : CalendarMonthViewModel
    
    func getDate(day: Int) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatterGet.date(from: "\(calendar.calendarMonth.year)-\(calendar.calendarMonth.month)-\(day)") {
            return date
        } else {
            print("Date could not be formatted: ")
            print("\(calendar.calendarMonth.year)-\(calendar.calendarMonth.month)-\(day)")
           return Date()
        }
    }
    
    func displayDay (week: Int, day: Int) -> some View {
        let currIdx = week*7+day+1
        let firstWeekday = calendar.getFirstWeekDay()
        let dayOfMonth = calendar.getDaysOfMonth()
        
        // Blank space at beginning of month
        if (currIdx <= firstWeekday) {
            return Text(""/*String(calendar.prevMonth().getDaysOfMonth()-(firstWeekday-currIdx))*/)
                .foregroundColor(.gray)
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(Color.white)
                .cornerRadius(0.0)
                .gesture(TapGesture().onEnded({
                }))
        }
            // Blank space at end of month
        else if (currIdx-firstWeekday > dayOfMonth) {
            return Text(""/*String(currIdx-firstWeekday-dayOfMonth)*/)
                .foregroundColor(.gray)
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(Color.white)
                .cornerRadius(0.0)
                .gesture(TapGesture().onEnded({
                }))
        }
            // Today's date
        else if (todayDay == currIdx-firstWeekday && todayMonth == calendar.calendarMonth.month && todayYear == calendar.calendarMonth.year) {
            
            
            return Text(String(currIdx-firstWeekday))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(weekDayColor[day])
                .cornerRadius(15.0)
                .gesture(TapGesture().onEnded({
                    self.viewControl.isShowingDayView = true
                    self.viewControl.dateShown = self.getDate(day: currIdx-firstWeekday)
                    //print("tapped")
                }))
        }
            // Plain days in calendar
        else {
            
            return Text(String(currIdx-firstWeekday))
                .foregroundColor(.black)
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(Color.white)
                .cornerRadius(0.0)
                .gesture(TapGesture().onEnded({
                    self.viewControl.isShowingDayView = true
                    self.viewControl.dateShown = self.getDate(day: currIdx-firstWeekday)
                    //print("tapped")
                }))
            
        }
    }
    
    var body: some View {
        
            VStack {
                HStack (spacing: 0.0){
                    Spacer()
                    Text("\(monthArr[(calendar.calendarMonth.month+11)%12]) \(String(calendar.calendarMonth.year))")
                        .font(.system(size: 30))
                        .fontWeight(.semibold).padding()
                    Spacer()
                }
                
                HStack (spacing: 0.0) {
                    ForEach(0..<7) { day in
                        Text(self.weekDayArr[day])
                            .bold()
                            .font(.system(size:20))
                            .foregroundColor(self.weekDayColor[day])
                            .shadow(radius: 0.5)
                            .frame(width: screenWidth/7)
                    }
                }.frame(width: screenWidth)
                
                ForEach(0..<6) { week in
                    HStack (spacing: 0.0){
                        ForEach(0..<7) { day in
                            self.displayDay(week: week, day: day)
                            
                            
                        }
                    }
                }
        }
        
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(calendar: CalendarMonthViewModel())
    }
}
