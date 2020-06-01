//
//  CalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI



/*func showYear () -> some View {
    return Text("")
}*/
let currCalendar = CurrCalendar()

struct CalendarView: View {
      let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

      let weekDayArr = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
      
      let daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      
      let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
      
      @ObservedObject var currCal : CurrCalendar
      //let currCal = currCalendar
      
      func displayDay (week: Int, day: Int) -> some View {
          let currIdx = week*7+day+1
          let firstWeekday = currCal.getFirstWeekDay()
          //print("first weekday: " + String(firstWeekday))
          if (currIdx <= firstWeekday || currIdx-firstWeekday > daysOfMonth[(self.currCal.currMonth+11)%12]) {
              return Text("").frame(width: screenWidth/7)
          } else {
              return Text(String(currIdx-firstWeekday)).frame(width: screenWidth/7)
              
          }
      }

      
      /*var isFirst : Bool
      var isLast : Bool
      
      @ObservedObject var listData: ScrollableCal.getData*/
      
      var body: some View {
              VStack {
                  /*Text("currMonth is: " + String(currCal.currMonth))
                  Text("currYear is: " + String(currCal.currYear))
                  Text("currDay is: " + String(currCal.currDay))
                  Text("currWeekday is: " + weekDayArr[currCal.currWeekDay-1])
                  Text("first weekday: " + String(weekDayArr[currCal.getFirstWeekDay()-1]))*/
                
                
                 
                 HStack (spacing: 0.0){
                     Button(action: {
                         // What to perform
                         self.currCal.prevMonth()
                         print(String(self.currCal.currYear))
                         //print(self.currCal.currWeekDay)
                     }) {
                         // How the button looks like
                       Text("prev").padding(.leading).frame(width: screenWidth*0.15, alignment: .leading)
                     }
                   
                       Text(self.monthArr[(self.currCal.currMonth+11)%12]+String(self.currCal.currYear)).font(.system(size: 30)).fontWeight(.semibold).padding().frame(width: screenWidth*0.7)
                  
                     Button(action: {
                         // What to perform
                         self.currCal.nextMonth()
                         print(String(self.currCal.currYear))
                       //print(self.currCal.currWeekDay)
                     }) {
                         // How the button looks like
                       Text("next").padding(.trailing).frame(width: screenWidth*0.15, alignment: .trailing)
                     }
                 }
                 
                 
                 HStack (spacing: 0.0) {
                      ForEach(0..<7) { day in
                          Text(self.weekDayArr[day]).bold().font(.system(size:20)).foregroundColor(self.weekDayColor[day]).shadow(radius: 0.5).frame(width: screenWidth/7)
                      }
                  }.frame(width: screenWidth)
                  
                  ForEach(0..<6) { week in
                      HStack (spacing: 0.0){
                          ForEach(0..<7) { day in
                              self.displayDay(week: week, day: day).frame(height: screenHeight*0.05)
                              
                          }
                      }
                  }
                 
                  
                  /*if (self.isFirst) {
                      Text("").onAppear(){
                          self.listData.prevMonth()
                          print("atFirst")
                      }
                  }
                  
                  if (self.isLast) {
                      Text("").onAppear(){
                          self.listData.nextMonth()
                          print("atLast")
                      }
                  }*/
            }.frame(width: screenWidth)
          
      }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(currCal: currCalendar/*isFirst: false, isLast: false*/)
    }
}
