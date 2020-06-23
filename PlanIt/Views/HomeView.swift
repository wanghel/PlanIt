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
        VStack (spacing: 0) {
            HStack {
                Text(session.profile?.firstName == "" ? "" : "Welcome back \(session.profile?.firstName ?? "") !")
                    .font(.system(size: 35))
                    .opacity(0.7)
                    .padding([.top, .horizontal])
                Spacer()
            }
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
