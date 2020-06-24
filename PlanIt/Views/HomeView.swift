//
//  HomeView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/13/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack (spacing: 0) {
            if session.profile?.firstName != "" {
                HStack {
                    Text("Welcome back \(session.profile?.firstName ?? "") !")
                        .font(.system(size: 25))
                        .opacity(0.7)
                        .padding([.top, .horizontal])
                    Spacer()
                }
            }
            MonthView(calendar: CalendarMonthViewModel())
            DayView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
