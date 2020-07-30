//
//  CalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State var showSmallCalendar = false
    @State var showingDetail = false
    
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        NavigationView {
            ZStack {
                darkerBackground
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        if !showSmallCalendar {
                            VStack {
                                LargeCalendarView(date: viewRouter.dateShown)
                                .offset(y: showSmallCalendar ? screenHeight : 0)
                                    .animation(.easeInOut(duration: 0.5))
                                    
                                Button(action: {
                                    withAnimation {
                                        self.showSmallCalendar.toggle()
                                    }
                                    print(self.viewRouter.dateShown)
                                }) {
                                    Image(systemName: "chevron.compact.up")
                                    .padding()
                                }
                            }
                            
                        }
                        
                        if showSmallCalendar {
                            VStack {
                                SmallCalendarView(date:  viewRouter.dateShown)
                                    .transition(.opacity)
                                
                                Button(action: {
                                    withAnimation {
                                        self.showSmallCalendar.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.compact.down")
                                    .padding()
                                }
                            }
                        }
                    }
                    
                    ScrollView {
                        VStack {
                            TaskView(date: viewRouter.dateShown)
                                .animation(.none)
                        }
                        .padding(.top)
                    }
                    
                }
            }
            .navigationBarTitle("\(monthArr[(viewRouter.dateShown.get(.month)+11)%12]) \(String(viewRouter.dateShown.get(.year)))", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.viewRouter.viewProfile = true
                }){
                    ProfilePicView(image: session.profilePic, size: 32)
                        .padding()
                    
                }, trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding()
            })
        }
            
        .sheet(isPresented: $showingDetail) {
            DetailView(showingDetail: self.$showingDetail, day: self.viewRouter.dateShown)
        }
    }
    
}

struct SmallCalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var draggedOffset = CGSize.zero
    
    @ObservedObject private var pWeek: CalendarWeekViewModel
    @ObservedObject private var cWeek: CalendarWeekViewModel
    @ObservedObject private var nWeek: CalendarWeekViewModel
    
    init(date: Date) {
        pWeek = CalendarWeekViewModel(date: date.addingTimeInterval(-604800))
        cWeek = CalendarWeekViewModel(date: date)
        nWeek = CalendarWeekViewModel(date: date.addingTimeInterval(604800))
    }
    
    private func nextView() {
        pWeek.getNextWeek()
        cWeek.getNextWeek()
        nWeek.getNextWeek()
    }
    
    private func prevView() {
        pWeek.getPrevWeek()
        cWeek.getPrevWeek()
        nWeek.getPrevWeek()
    }
    
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                WeekView(week: pWeek)
                WeekView(week: cWeek)
                WeekView(week: nWeek)
            }
            .offset(x: self.draggedOffset.width)
            .gesture(DragGesture()
                .onChanged { value in
                    self.draggedOffset = value.translation
            }
            .onEnded { value in
                if self.draggedOffset.width > screenWidth/2 {
                    self.draggedOffset.width = -screenWidth
                    self.draggedOffset = CGSize.zero
                    self.viewRouter.dateShown = self.pWeek.date
                    self.prevView()
                }
                else if self.draggedOffset.width < -screenWidth/2 {
                    self.draggedOffset.width = screenWidth
                    self.draggedOffset = CGSize.zero
                    self.viewRouter.dateShown = self.nWeek.date
                    self.nextView()
                } else {
                    self.draggedOffset = CGSize.zero
                }
            })
        }
    }
}

struct WeekView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var week : CalendarWeekViewModel
    
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    let color = [pink, red, orange, yellow, green, blue, purple]
    
    func getDate (year: Int, month: Int, day: Int) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatterGet.date(from: "\(year)-\(month)-\(day)") {
            return date
        } else {
            print("Date could not be formatted: ")
            print("\(year)-\(month)-\(day)")
           return Date()
        }
    }
    
    var body: some View {
        HStack (spacing: 0) {
            ForEach(0..<7) { day in
                    VStack {
                        Text(self.weekdays[day])
                            .font(.system(size: 13))
                            .bold()
                            .shadow(radius: 5)
                        Text(String(self.week.week[day]))
                            .font(.system(size: 17))
                            .bold()
                            .shadow(radius: 5)
                    }
                    .padding()
                    .frame(width: screenWidth/7, height: 60)
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: self.getDate(year: self.week.calendarWeek.year, month: self.week.calendarWeek.month, day: self.week.week[day]).isSameDay(self.viewRouter.dateShown) ? 5 : 0)
                                .fill(self.getDate(year: self.week.calendarWeek.year, month: self.week.calendarWeek.month, day: self.week.week[day]).isSameDay(self.viewRouter.dateShown) ? self.color[day] : Color.gray)
                                .opacity(0.9)
                                .frame(height: self.getDate(year: self.week.calendarWeek.year, month: self.week.calendarWeek.month, day: self.week.week[day]).isSameDay(self.viewRouter.dateShown) ? 70 : 60)
                            Spacer()
                    })
                        .onTapGesture {
                            let weekday = Calendar.current.component(.weekday, from: self.week.date)
                            var date = self.viewRouter.dateShown
                            
                            if day < weekday-1 {
                                date = self.week.date.advanced(by: TimeInterval(-86400 * ((weekday-1)-day)))
                            }
                            else if day > weekday-1 {
                                date = self.week.date.addingTimeInterval(TimeInterval(86400*(day-(weekday-1))))
                            }
                            self.viewRouter.dateShown = date
                            self.week.date = date
                }
                
            }
        }
    }
}

struct LargeCalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject private var pMonth: CalendarMonthViewModel
    @ObservedObject private var cMonth: CalendarMonthViewModel
    @ObservedObject private var nMonth: CalendarMonthViewModel
    
    @State private var draggedOffset = CGSize.zero
    
    let weekDayArr = ["S", "M", "T", "W", "T", "F", "S"]
    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
    init(date: Date) {
        pMonth = CalendarMonthViewModel(date: date/*.addingTimeInterval(-2592000)*/)
        cMonth = CalendarMonthViewModel(date: date)
        nMonth = CalendarMonthViewModel(date: date/*.addingTimeInterval(2592000)*/)
        
        pMonth.prevMonth()
        nMonth.nextMonth()
    }
    
    func getDate (year: Int, month: Int, day: Int) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatterGet.date(from: "\(year)-\(month)-\(day)") {
            return date
        } else {
            print("Date could not be formatted: ")
            print("\(year)-\(month)-\(day)")
           return Date()
        }
    }
    
    private func nextView() {
        pMonth.nextMonth()
        cMonth.nextMonth()
        nMonth.nextMonth()
        
        viewRouter.dateShown = getDate(year: cMonth.calendarMonth.year, month: cMonth.calendarMonth.month, day: 1)
    }
    
    private func prevView() {
        pMonth.prevMonth()
        cMonth.prevMonth()
        nMonth.prevMonth()
        
        viewRouter.dateShown = getDate(year: cMonth.calendarMonth.year, month: cMonth.calendarMonth.month, day: 1)
    }
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    ForEach(0..<7) { day in
                        HStack (spacing: 0){
                            Spacer()
                            Text(self.weekDayArr[day])
                                .bold()
                                .font(.system(size: 15))
                                .foregroundColor(self.weekDayColor[day])
                            Spacer()
                        }
                    }
                }
                .padding([.horizontal, .top])
                .frame(width: screenWidth)
                
                HStack {
                    MonthView(calendar: self.pMonth)
                        .frame(width: screenWidth)
                    MonthView(calendar: self.cMonth)
                        .frame(width: screenWidth)
                    MonthView(calendar: self.nMonth)
                        .frame(width: screenWidth)
                }
                .animation(.none)
                .offset(x:
                self.draggedOffset.width)
                .gesture(DragGesture()
                    .onChanged { value in
                        self.draggedOffset = value.translation
                }
                .onEnded { value in
                    if(self.draggedOffset.width > screenWidth/2) {
                        self.prevView()
                    }
                    else if (self.draggedOffset.width < -screenWidth/2) {
                        self.nextView()
                    }
                    self.draggedOffset = CGSize.zero
                })
                
            }
        }
    }
}

struct MonthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let todayDay = Calendar.current.component(.day, from: Date())
    let todayMonth = Calendar.current.component(.month, from: Date())
    let todayYear = Calendar.current.component(.year, from: Date())
    
    @ObservedObject var calendar : CalendarMonthViewModel
    
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
                                            .fill(self.isToday(day: element) ? Color.gray : Color.clear)
                                            .frame(width: screenWidth/8, height: 40))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(self.isSelected(day: element) ? Color.gray : Color.clear, lineWidth: 2)
                                            .frame(width: screenWidth/8, height: 40))
                                    .gesture(TapGesture().onEnded({
                                        self.viewRouter.dateShown = self.getDate(day: element)
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

struct FriendCalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var friendProfile: UserViewModel
    
    @State var showSmallCalendar = false
    @State var showingDetail = false
    
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("\(monthArr[(viewRouter.dateShown.get(.month)+11)%12]) \(String(viewRouter.dateShown.get(.year)))")
                    .font(.custom("andromeda", size: 23))
                    .padding()
                    .frame(width: screenWidth, alignment: .center)
                    .background(darkestBackground)
                
                ZStack {
                    if !showSmallCalendar {
                        VStack {
                            LargeCalendarView(date: viewRouter.dateShown)
                                .offset(y: showSmallCalendar ? screenHeight : 0)
                                .animation(.easeInOut(duration: 0.5))
                            
                            Button(action: {
                                withAnimation {
                                    self.showSmallCalendar.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.compact.up")
                                .padding()
                            }
                        }
                        
                    }
                    
                    if showSmallCalendar {
                        VStack {
                            SmallCalendarView(date: viewRouter.dateShown)
                                .transition(.opacity)
                            
                            Button(action: {
                                withAnimation {
                                    self.showSmallCalendar.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.compact.down")
                                .padding()
                            }
                        }
                    }
                }
                
                ScrollView {
                    VStack {
                        FriendTaskView(friendProfile: friendProfile, date: viewRouter.dateShown)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#if DEBUG
struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ViewRouter())
    }
}
#endif
