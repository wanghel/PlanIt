//
//  HomeView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/13/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            MonthView(calendar: CalendarMonthViewModel(), isShowingDayView: .constant(false), dayViewDate: .constant(Date()))
                .allowsHitTesting(false)
            Spacer()
            Text("Reminders for Today")
            Spacer()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
