//
//  InfiniteCalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct InfiniteCalendarView: View {
    @State private var pMonth : CurrCalendar = CurrCalendar()
    @State private var cMonth : CurrCalendar = CurrCalendar()
    @State private var nMonth : CurrCalendar = CurrCalendar()
    
    @State private var draggedOffset = CGSize.zero
   
    init () {
        pMonth.prevMonth()
        nMonth.nextMonth()
    }
    
    private func nextView() {
        pMonth.nextMonth()
        cMonth.nextMonth()
        nMonth.nextMonth()
    }
    
    private func prevView() {
        pMonth.prevMonth()
        cMonth.prevMonth()
        nMonth.prevMonth()
    }
    
    var body: some View {
        VStack{
            MonthView(calendar: pMonth).opacity(0.3).allowsHitTesting(false)
            MonthView(calendar: cMonth)
            MonthView(calendar: nMonth).opacity(0.3).allowsHitTesting(false)
        }.offset(y: self.draggedOffset.height).gesture(DragGesture()
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                if (value.translation.height > screenHeight/10) {
                    self.prevView()
                } else if (value.translation.height < -screenHeight/10) {
                    self.nextView()
                }
                self.draggedOffset = CGSize.zero
            }
        )
    }
}

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCalendarView()
    }
}
