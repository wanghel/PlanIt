//
//  InfiniteCalendarView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct InfiniteCalendarView: View {
    @State private var p1Month : Month = Month().prevMonth()
    @State private var p2Month : Month = Month().prevMonth().prevMonth()
    @State private var cMonth : Month = Month()
    @State private var n1Month : Month = Month().nextMonth()
    @State private var n2Month : Month = Month().nextMonth().nextMonth()
    
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
        VStack {
            MonthView(calendar: p2Month).opacity(0.2).allowsHitTesting(false)
            MonthView(calendar: p1Month).opacity(0.2).allowsHitTesting(false)
            MonthView(calendar: cMonth)
            MonthView(calendar: n1Month).opacity(0.2).allowsHitTesting(false)
            MonthView(calendar: n2Month).opacity(0.2).allowsHitTesting(false)
        }.offset(y: self.lastOffset.height + self.draggedOffset.height)
        .gesture(DragGesture()
        .onChanged { value in
            self.draggedOffset = value.translation
        }
        .onEnded { value in
            let offset : CGSize
            if (self.lastOffset.height + self.draggedOffset.height > screenHeight/3) {
                offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height - screenHeight * 0.4)
                self.prevView()
            } else if (self.lastOffset.height + self.draggedOffset.height < -screenHeight/10) {
                offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height + screenHeight * 0.4)
                self.nextView()
            } else {
                offset = CGSize(width: self.lastOffset.width, height: self.lastOffset.height + self.draggedOffset.height)
            }
            print(self.draggedOffset.height)
            self.lastOffset = offset
            self.draggedOffset = CGSize.zero
        }).navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(leading: Text("Hi, Helen"), trailing: Image(systemName: "person.3"))
        
        /*.offset(y: self.draggedOffset.height)
            .gesture(DragGesture()
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                if (value.translation.height > screenHeight/5) {
                    self.prevView()
                } else if (value.translation.height < -screenHeight/5) {
                    self.nextView()
                }
                print(self.draggedOffset.height)
                self.draggedOffset = CGSize.zero
            }).navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(leading: Text("Hi, Helen"), trailing: Image(systemName: "person.3"))*/
        
    }
}

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCalendarView()
    }
}
