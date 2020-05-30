//
//  ReminderDayView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct ReminderDayView: View {
    var color: Color
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color.white).frame(width: screenWidth, height: screenHeight).background(color)
    }
}

struct ReminderDayView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDayView(color: Color.black)
    }
}
