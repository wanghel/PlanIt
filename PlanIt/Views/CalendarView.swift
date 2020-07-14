//
//  CalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

//import SwiftUI
//
//struct CalendarView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//
//    @State private var draggedOffset = CGSize.zero
//    @State var showSmallCalendar = false
//
//    var body: some View {
//        ZStack {
//            dnavy
//            .edgesIgnoringSafeArea(.all)
//
//            ZStack {
////                if !showSmallCalendar {
////                    LargeCalendarView()
////                }
////                if showSmallCalendar {
//                    SmallCalendarView()
////                }
//            }
//            .offset(y: self.draggedOffset.height)
//            .gesture(DragGesture()
//                .onChanged { value in
//                    self.draggedOffset = value.translation
//            }
//            .onEnded { value in
//                if self.draggedOffset.height < -screenHeight/4 && !self.showSmallCalendar {
//                    self.showSmallCalendar.toggle()
//                }
//                if self.draggedOffset.height > screenHeight/6 {
//                    self.showSmallCalendar.toggle()
//                }
//                self.draggedOffset = CGSize.zero
//            })
//        }
//    }
//}
//
//struct SmallCalendarView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//
//    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
//    let color = [pink, red, orange, yellow, green, blue, purple]
//
//    var body: some View {
//        VStack {
//            HStack (spacing: 0){
//
//                ForEach(0..<7) { day in
//                    Text(self.weekdays[day])
//                        .bold()
//                        .shadow(radius: 5)
//
//                        .padding()
//                        .frame(width: screenWidth/7)
//                        .background(RoundedRectangle(cornerRadius: 0)
//                            .fill(self.color[day]))
//
//                }
//            }
//
//            ScrollView {
//                VStack {
//                    TaskView()
//                }
//                .padding(.top)
//            }
//        }
//    }
//}
//
//struct LargeCalendarView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//
//    @State private var pMonth :CalendarMonthViewModel = CalendarMonthViewModel().prevMonth()
//    @State private var cMonth :CalendarMonthViewModel = CalendarMonthViewModel()
//    @State private var nMonth :CalendarMonthViewModel = CalendarMonthViewModel().nextMonth()
//
//    @State private var draggedOffset = CGSize.zero
//    @State private var lastOffset = CGSize.zero
//
//    @State var showingDetail = false
//
//    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
//
//    let weekDayArr = ["S", "M", "T", "W", "T", "F", "S"]
//
//    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
//
//    private func nextView() {
//        pMonth = pMonth.nextMonth()
//        cMonth = cMonth.nextMonth()
//        nMonth = nMonth.nextMonth()
//    }
//
//    private func prevView() {
//        pMonth = pMonth.prevMonth()
//        cMonth = cMonth.prevMonth()
//        nMonth = nMonth.prevMonth()
//    }
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                dnavy
//                    .edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    HStack {
//                        ForEach(0..<7) { day in
//                            HStack (spacing: 0){
//                                Spacer()
//                                Text(self.weekDayArr[day])
//                                    .bold()
//                                    .font(.system(size: 15))
//                                    .foregroundColor(self.weekDayColor[day])
//                                Spacer()
//                            }
//                        }
//                    }
//                    .padding([.horizontal, .top])
//                    .frame(width: screenWidth)
//
//                    HStack {
//                        MonthView(calendar: self.pMonth)
//                            .frame(width: screenWidth)
//                        MonthView(calendar: self.cMonth)
//                            .frame(width: screenWidth)
//                        MonthView(calendar: self.nMonth)
//                            .frame(width: screenWidth)
//                    }
//                    .offset(x: self.lastOffset.width +
//                        self.draggedOffset.width)
//                        .gesture(DragGesture()
//                            .onChanged { value in
//                                self.draggedOffset = value.translation
//                        }
//                        .onEnded { value in
//                            if(self.draggedOffset.width + self.lastOffset.width > screenWidth/2) {
//                                self.lastOffset = CGSize(width: -screenWidth, height: 0)
//                                self.prevView()
//                                self.lastOffset = CGSize.zero
//                            }
//                            else if (self.draggedOffset.width + self.lastOffset.width < -screenWidth/2) {
//                                self.lastOffset = CGSize(width: screenWidth, height: 0)
//                                self.nextView()
//                                self.lastOffset = CGSize.zero
//                            } else {
//                                self.lastOffset = CGSize.zero
//                            }
//                            self.draggedOffset = CGSize.zero
//                        })
//
//                    ScrollView {
//                        VStack {
//                            TaskView()
//                        }
//                        .padding(.top)
//                    }
//                }
//            }
//            .navigationBarTitle("\(monthArr[(cMonth.calendarMonth.month+11)%12]) \(String(cMonth.calendarMonth.year))", displayMode: .inline)
//            .navigationBarItems(leading:
//                Button(action: {
//                    self.viewRouter.viewProfile = true
//                }){
//                    Image(systemName: "person.crop.circle.fill")
//                        .font(.system(size: 25))
//                        .foregroundColor(.white)
//                        .opacity(0.9)
//                        .padding(.bottom)
//                }, trailing:
//                Button(action: {
//                    self.showingDetail.toggle()
//                }){
//                    Image(systemName: "plus")
//                        .font(.system(size: 25))
//                        .foregroundColor(.white)
//                        .opacity(0.9)
//                        .padding(.bottom)
//            })
//        }
//        .sheet(isPresented: $showingDetail) {
//            DetailView(showingDetail: self.$showingDetail, day: self.viewRouter.dateShown)
//        }
//    }
//}
//
//struct InfiniteCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
////        CalendarView()
////        .environmentObject(ViewRouter())
//        SmallCalendarView()
//        .environmentObject(ViewRouter())
//    }
//}

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var showSmallCalendar = false
    @State var showingDetail = false
    
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        if !showSmallCalendar {
                            VStack {
                                LargeCalendarView()
                                .offset(y: showSmallCalendar ? screenHeight : 0)
                                    .animation(.easeInOut(duration: 0.5))
                                    
                                Button(action: {
                                    withAnimation {
                                        self.showSmallCalendar.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.compact.up")
                                }
                            }
                            
                        }
                        
                        if showSmallCalendar {
                            VStack {
                                SmallCalendarView()
                                    .transition(.opacity)
                                
                                Button(action: {
                                    withAnimation {
                                        self.showSmallCalendar.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.compact.down")
                                }
                            }
                        }
                    }
                    
                    ScrollView {
                        VStack {
                            TaskView()
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
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding(.bottom)
                }, trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding(.bottom)
            })
        }
        
            .sheet(isPresented: $showingDetail) {
                DetailView(showingDetail: self.$showingDetail, day: self.viewRouter.dateShown)
        }
    }
    
}

struct SmallCalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    let color = [pink, red, orange, yellow, green, blue, purple]
    
    var body: some View {
        VStack {
            HStack (spacing: 0){
                
                ForEach(0..<7) { day in
                    Text(self.weekdays[day])
                        .bold()
                        .shadow(radius: 5)
                        
                        .padding()
                        .frame(width: screenWidth/7)
                        .background(RoundedRectangle(cornerRadius: 0)
                            .fill(self.color[day]))
                    
                }
            }
        }
    }
}

struct LargeCalendarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var pMonth :CalendarMonthViewModel = CalendarMonthViewModel().prevMonth()
    @State private var cMonth :CalendarMonthViewModel = CalendarMonthViewModel()
    @State private var nMonth :CalendarMonthViewModel = CalendarMonthViewModel().nextMonth()
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    


    let weekDayArr = ["S", "M", "T", "W", "T", "F", "S"]

    let weekDayColor = [pink, red, orange, yellow, green, blue, purple]
    
    private func nextView() {
        pMonth = pMonth.nextMonth()
        cMonth = cMonth.nextMonth()
        nMonth = nMonth.nextMonth()
    }
    
    private func prevView() {
        pMonth = pMonth.prevMonth()
        cMonth = cMonth.prevMonth()
        nMonth = nMonth.prevMonth()
    }
    
    var body: some View {
        ZStack {
            dnavy
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
                .offset(x: self.lastOffset.width +
                    self.draggedOffset.width)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.draggedOffset = value.translation
                    }
                    .onEnded { value in
                        if(self.draggedOffset.width + self.lastOffset.width > screenWidth/2) {
                            self.lastOffset = CGSize(width: -screenWidth, height: 0)
                            self.prevView()
                            self.lastOffset = CGSize.zero
                        }
                        else if (self.draggedOffset.width + self.lastOffset.width < -screenWidth/2) {
                            self.lastOffset = CGSize(width: screenWidth, height: 0)
                            self.nextView()
                            self.lastOffset = CGSize.zero
                        } else {
                            self.lastOffset = CGSize.zero
                        }
                        self.draggedOffset = CGSize.zero
                    })
                
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
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    if !showSmallCalendar {
                        VStack {
                            LargeCalendarView()
                                .offset(y: showSmallCalendar ? screenHeight : 0)
                                .animation(.easeInOut(duration: 0.5))
                            
                            Button(action: {
                                withAnimation {
                                    self.showSmallCalendar.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.compact.up")
                            }
                        }
                        
                    }
                    
                    if showSmallCalendar {
                        VStack {
                            SmallCalendarView()
                                .transition(.opacity)
                            
                            Button(action: {
                                withAnimation {
                                    self.showSmallCalendar.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.compact.down")
                            }
                        }
                    }
                }
                
                ScrollView {
                    VStack {
                        FriendTaskView(friendProfile: friendProfile)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(ViewRouter())
    }
}

