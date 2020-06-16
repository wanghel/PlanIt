//
//  InfiniteCalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewControl: ViewControl
    
    @State private var p1Month :CalendarMonthViewModel = CalendarMonthViewModel().prevMonth()
    @State private var p2Month :CalendarMonthViewModel = CalendarMonthViewModel().prevMonth().prevMonth()
    @State private var cMonth :CalendarMonthViewModel = CalendarMonthViewModel()
    @State private var n1Month :CalendarMonthViewModel = CalendarMonthViewModel().nextMonth()
    @State private var n2Month :CalendarMonthViewModel = CalendarMonthViewModel().nextMonth().nextMonth()
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    
    private func nextView() {
        p1Month = p1Month.nextMonth()
        p2Month = p2Month.nextMonth()
        cMonth = cMonth.nextMonth()
        n1Month = n1Month.nextMonth()
        n2Month = n2Month.nextMonth()
    }
    
    private func prevView() {
        p1Month = p1Month.prevMonth()
        p2Month = p2Month.prevMonth()
        cMonth = cMonth.prevMonth()
        n1Month = n1Month.prevMonth()
        n2Month = n2Month.prevMonth()
    }
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                VStack {
                    MonthView(calendar: self.p2Month)
                        .clipped()
                        .opacity(0.5)
                        .allowsHitTesting(false)
                    MonthView(calendar: self.p1Month)
                    .clipped()
                    MonthView(calendar: self.cMonth)
                    MonthView(calendar: self.n1Month)
                    .clipped()
                    MonthView(calendar: self.n2Month)
                        .clipped()
                        .opacity(0.5)
                        .allowsHitTesting(false)
                }
                .offset(y: self.lastOffset.height +
                    self.draggedOffset.height)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.draggedOffset = value.translation
                    }
                    .onEnded { value in
                        let offset : CGSize
                        if (self.lastOffset.height + self.draggedOffset.height > screenHeight/2) {
                            offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height - screenHeight * 0.8)
                            self.prevView()
                            self.prevView()
                        }
                        else if (self.lastOffset.height + self.draggedOffset.height < -screenHeight/2) {
                            offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height + screenHeight * 0.8)
                            self.nextView()
                            self.nextView()
                        }
                        else if (self.lastOffset.height + self.draggedOffset.height > screenHeight/10) {
                            offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height - screenHeight * 0.4)
                            self.prevView()
                        }
                        else if (self.lastOffset.height + self.draggedOffset.height < -screenHeight/10) {
                            offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height + screenHeight * 0.4)
                            self.nextView()
                        }
                        else {
                            offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height)
                        }
                        print(self.draggedOffset.height)
                        self.lastOffset = offset
                        self.draggedOffset = CGSize.zero
                })
            }
            
            DayView()
            
        }
        
    }
}

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
