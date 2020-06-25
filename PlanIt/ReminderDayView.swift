//
//  ReminderDayView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct ReminderDayView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: MonthView(calendar: CalendarMonthViewModel())){
                Text("click")
                
            }
        }
        
    }
    
}

struct ReminderDayView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDayView()
    }
}
