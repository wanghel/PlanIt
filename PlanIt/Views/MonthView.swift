//
//  MonthView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/31/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct MonthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
//    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

//    let weekDayArr = ["S", "M", "T", "W", "T", "F", "S"]
//
//    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
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
    
    func isToday(day: Int) -> Bool {
        return day == todayDay && calendar.calendarMonth.month == todayMonth && calendar.calendarMonth.year == todayYear
    }
    
    func isSelected(day: Int) -> Bool {
        return day != -1 && getDate(day: day).isSameDay(viewRouter.dateShown)
    }
    
    var body: some View {
        
            VStack {
//                HStack {
//                    Spacer()
//                    Text("\(monthArr[(calendar.calendarMonth.month+11)%12]) \(String(calendar.calendarMonth.year))")
//                        .font(.system(size: 25))
//                        .foregroundColor(.white)
//                        .opacity(0.7)
//                        .padding()
//                    Spacer()
//                }
                
                
//                HStack {
//                    ForEach(0..<7) { day in
//                        HStack (spacing: 0){
//                            Spacer()
//                            Text(self.weekDayArr[day])
//                                .bold()
//                                .font(.system(size: 15))
//                                .foregroundColor(self.weekDayColor[day])
//                            Spacer()
//                        }
//                    }
//                }
//                .padding(.horizontal)
                
                
                ForEach(calendar.getDays(), id: \.self) { array in
                    HStack {
                        ForEach(array, id: \.self) { element in
                            HStack (spacing: 0){
                                Spacer()
                                
                                Text(element == -1 ? "" : String(element))
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .fill(self.isToday(day: element) ? orange : Color.clear)
                                            .frame(width: screenWidth/8, height: 40))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(self.isSelected(day: element) ? Color.white : Color.clear, lineWidth: 2)
                                        .frame(width: screenWidth/8, height: 40))
                                .gesture(TapGesture().onEnded({
                                
                                }))
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                
        }
        
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(calendar: CalendarMonthViewModel())
        .environmentObject(ViewRouter())
    }
}
