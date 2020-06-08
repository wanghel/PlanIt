//
//  MonthView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/31/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct MonthView: View {
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    let weekDayArr = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
    let todayDay: Int = Calendar.current.component(.day, from: Date())
    let todayMonth = Calendar.current.component(.month, from: Date())
    let todayYear = Calendar.current.component(.year, from: Date())

    @ObservedObject var calendar : Month
    
    init (calendar: Month) {
        self.calendar = calendar
    }
    
    init (month: Int, year: Int) {
        calendar = Month(month: month, year: year)
    }
    
    func displayDay (week: Int, day: Int) -> some View {
        let currIdx = week*7+day+1
        let firstWeekday = calendar.getFirstWeekDay()
        let dayOfMonth = calendar.getDaysOfMonth()
        
        // Blank space at beginning and end of month
        if (currIdx <= firstWeekday || currIdx-firstWeekday > dayOfMonth) {
            return Text("")
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(Color.white)
                .cornerRadius(0.0)
        }
        // Today's date
        else if (todayDay == currIdx-firstWeekday && todayMonth == calendar.currMonth && todayYear == calendar.currYear) {
            return Text(String(currIdx-firstWeekday))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(weekDayColor[day])
                .cornerRadius(15.0)
        }
        // Plain days in calendar
        else {
            return Text(String(currIdx-firstWeekday))
                .frame(width: screenWidth/7, height: screenHeight*0.05)
                .background(Color.white)
                .cornerRadius(0.0)
        }
    }
    
    var body: some View {
        VStack {
             HStack (spacing: 0.0){
                /*Button(action: {
                    self.calendar.prevMonth()
                }) {
                  Text("prev").padding(.leading).frame(alignment: .leading)
                }*/
                
                Spacer()
                  Text("\(monthArr[(calendar.currMonth+11)%12]) \(String(calendar.currYear))").font(.system(size: 30)).fontWeight(.semibold).padding()
                Spacer()
             
                /*Button(action: {
                    self.calendar.nextMonth()
                }) {
                  Text("next")
                    .padding(.trailing)
                    .frame(alignment: .trailing)
                }*/
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
                        //NavigationLink (destination: DayView(day: day)) {
                            self.displayDay(week: week, day: day)
                        //}.buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }
        }.frame(height: screenHeight*0.4)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(calendar: Month())
    }
}
