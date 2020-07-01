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
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            Image("space")
                .resizable()
                .edgesIgnoringSafeArea(.bottom)
                .frame(width: screenWidth * 3)
                .offset(x: 250, y: -50)
                .clipped()
        }
        
        
        
    }
    
}

struct ReminderDayView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDayView()
    }
}
