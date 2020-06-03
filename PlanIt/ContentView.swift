//
//  ContentView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height



struct ContentView: View {
   
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                //MonthView(calendar: Month())
                InfiniteCalendarView().frame(height: screenHeight/2)
                Spacer()
                WeekdaysView()
            }

        }
    }
}


struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
