//
//  WeekdaysView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

let pink = Color(red: 1.0, green: 0.8, blue: 0.8)
let red = Color(red: 1.0, green: 0.6, blue: 0.6)
let orange = Color(red: 1.0, green: 0.7, blue: 0.6)
let yellow = Color(red: 1.0, green: 0.9, blue: 0.5)
let green = Color(red: 0.8, green: 0.97, blue: 0.6)
let blue = Color(red: 0.7, green: 0.95, blue: 0.9)
let purple = Color(red: 0.9, green: 0.7, blue: 0.9)

/*let weekDayArr = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
let letterArr = ["S", "M", "T", "W", "T", "F", "S"]

let weekDayColor = [pink, red, orange, yellow, green, blue, purple]

struct LabelImage: View {
    var img: String
    var body: some View {
        Image(img)
            .resizable()
            .frame(width: 150)
    }
}

struct Slider: View {
    var day: String
    var image: String
    var color: Color
    var body: some View
    {
        
        Text(day)
            .font(.title)
            .fontWeight(.light)
            .foregroundColor(.white)
            .padding()
            .shadow(radius: 10)
            .frame(width: screenWidth/7, height: screenHeight*0.1)
            .background(color)
            .cornerRadius(10)
        
    }
}

struct WeekdaysView: View {
    @State private var showingReminderView = false
    
    var body: some View {
        
        HStack(spacing: 0.0) {
            ForEach(0..<7) { day in
                Button (action: {
                    self.showingReminderView.toggle()
                }){
                    Slider(day: letterArr[day], image: "planet1", color: weekDayColor[day])
                }.sheet(isPresented: self.$showingReminderView){
                    ReminderDayView(day: weekDayArr[day], color: weekDayColor[day])
                }
            }
            
            
            
            /*NavigationLink (destination: ReminderDayView(day: "Sunday", color: pink)) {
             Slider(day: "S", image: "planet1", color: pink)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Monday", color: red)) {
             Slider(day: "M", image: "planet1", color: red)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Tuesday", color: orange)) {
             Slider(day: "T", image: "planet1", color: orange)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Wednesday", color: yellow)) {
             Slider(day: "W", image: "planet1", color: yellow)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Thursday", color: green)) {
             Slider(day: "T", image: "planet1", color: green)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Friday", color: blue)) {
             Slider(day: "F", image: "planet1", color: blue)
             }
             
             NavigationLink (destination: ReminderDayView(day: "Saturday", color: purple)) {
             Slider(day: "S", image: "planet1", color: purple)
             }*/
            
        }
        
    }
}*/

//struct WeekdaysView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeekdaysView()
//    }
//}
