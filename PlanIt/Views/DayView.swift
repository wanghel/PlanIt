//
//  DayView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var dayEventsVM = DayEventsViewModel()
    @Binding var isShowingDayView : Bool
    
    func printTime(hour: Int) -> String {
        return "\(hour%12 == 0 ? 12 : hour%12) \(hour/12 == 0 ? "AM" : "PM")"
    }
    
    @Binding var dayViewDate: Date
    
    /*func getColor(eventVM: EventViewModel) -> Color {
        switch eventVM.event.color {
        case "pink":
            return pink
        case "red":
            return red
        case "orange":
            return orange
        case "yellow":
            return yellow
        case "green":
            return green
        case "blue":
            return blue
        case "purple":
            return purple
        default:
            return Color.black
        }
    }
    
    func eventBar(eventVM: EventViewModel) -> some View {
        Rectangle()
        .size(width: 20, height: CGFloat(eventVM.duration()/30))
        .fill(getColor(eventVM: eventVM))
        .cornerRadius(5)
    }*/

    
    var body: some View {
        VStack (spacing:0){
            
            //Spacer(minLength: 60 + (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            
            DayBarView(isShowingDayView: $isShowingDayView, dayViewDate: $dayViewDate)
            .background(Color.white)
                
            ScrollView {
                ForEach(0..<24) { hour in
                    HStack {
                        Text(self.printTime(hour: hour))
                            .foregroundColor(.gray)
                            .frame(width: 50, alignment: .trailing)
                            .padding([.bottom, .leading])
                        Divider()
                        Spacer()
                    }
                }
            }
            .background(Color.white)
            //Spacer(minLength: 50 + (UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
        }
        .edgesIgnoringSafeArea(.vertical)
        .offset(x: isShowingDayView ? 0 : -screenWidth)
        .animation(.default)
        
    }
}

//small nav bar extended from main nav bar
struct DayBarView: View {
    @Binding var isShowingDayView : Bool
    @Binding var dayViewDate: Date
    
    func formatDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: dayViewDate)
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.dayViewDate.addTimeInterval(TimeInterval(-86400))
                    }){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                    Text(formatDate())
                        .font(.system(size: 20))
                        .opacity(0.7)
                        .padding(.horizontal)
                    Button(action: {
                        self.dayViewDate.addTimeInterval(TimeInterval(86400))
                    }){
                        Image(systemName: "chevron.right")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                    Spacer()
                }
                    
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowingDayView.toggle()
                    }){
                        HStack (spacing: 5) {
                            Image(systemName: "calendar")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                                .opacity(0.5)
                            Image(systemName: "chevron.right")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .opacity(0.5)
                        }
                    }
                }
                .frame(height: 40)
                .padding(.horizontal)
                .clipped()
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayEventsVM: DayEventsViewModel(), isShowingDayView: .constant(true), dayViewDate: .constant(Date()))
    }
}
