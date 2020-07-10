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
    
    @State private var pMonth :CalendarMonthViewModel = CalendarMonthViewModel().prevMonth()
    @State private var cMonth :CalendarMonthViewModel = CalendarMonthViewModel()
    @State private var nMonth :CalendarMonthViewModel = CalendarMonthViewModel().nextMonth()
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    
    @State var showingDetail = false
    
    let monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
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
        NavigationView {
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
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                Text("No tasks :)")
                                    .foregroundColor(.white)
                                    .font(.custom("GillSans", size: 20))
                                Spacer()
                            }
                            
                            TaskView()
                        }
                    }
                }
            }
            .navigationBarTitle("\(monthArr[(cMonth.calendarMonth.month+11)%12]) \(String(cMonth.calendarMonth.year))", displayMode: .inline)
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

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
