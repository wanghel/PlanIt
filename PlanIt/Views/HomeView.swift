//
//  HomeView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/13/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Text("Welcome back \(session.profile?.firstName ?? "")")
            MonthView(calendar: CalendarMonthViewModel())
            //Spacer()
            DayView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
