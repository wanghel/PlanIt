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
                       /*Text("Calendar")
                           .font(.largeTitle)
                           .fontWeight(.light)
                           .foregroundColor(Color.black)
                           .frame(width: screenWidth, height: screenHeight*0.7)*/
                    /*CalendarView().frame(width: screenWidth, alignment: .top)*/
                    CalendarView(currCal: CurrCalendar()).frame(width: screenWidth, alignment: .top)
                       
                       Spacer()
                       DaysView()
                   }.padding(.bottom, 0.0)
                    .frame(alignment: .bottom)
                    .navigationBarTitle(Text("Today").fontWeight(.light).foregroundColor(.white))
        }

        
    }
}


struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
