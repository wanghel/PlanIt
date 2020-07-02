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
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingDetail = false
    
    func formatDate(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormatterPrint.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
//                ReminderDayView()
//                    .opacity(0.5)
//                    .frame(width: screenWidth)
//                    .edgesIgnoringSafeArea(.bottom)
                
                
                VStack (spacing: 0) {
                    //MonthView(calendar: CalendarMonthViewModel())
                    Text("~THIS WEEK~")
                    .tracking(10)
                        .padding()
                        .foregroundColor(.white)
                        .font(.custom("GillSans", size: 30))
                        .opacity(0.9)
                    
                    ScrollView {
                        // IDK WHY DOING THIS MAKES THE DATA LOAD
                        Text("")
                            .frame(width: screenWidth, height: 0)
                        // FIGURE IT OUT FUTURE ME
                        
                        ForEach (0..<7) { day in
                            VStack {
                                HStack {
                                    Text(self.formatDate(date: Date().addingTimeInterval(TimeInterval(day * 86400))))
                                        .foregroundColor(.white)
                                        .font(.custom("GillSans", size: 15))
                                        .opacity(0.9)
                                        .padding(10)
                                        .background(blue.opacity(0.2).cornerRadius(15))
                                    Spacer()
                                }
                                .padding(.vertical)
                                
                                ZStack {
                                    Text("No tasks :)")
                                        .foregroundColor(.white)
                                        .font(.custom("GillSans", size: 20))
                                    
                                    TaskView(dayFromCurr: day)
                                }
                            }
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("PLANIT", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.viewRouter.viewProfile = true
                }){
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding(.bottom)
                }, trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding(.bottom)
            })
        }
        .sheet(isPresented: $showingDetail) {
            DetailView(showingDetail: self.$showingDetail)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        .environmentObject(SessionStore())
        .environmentObject(ViewRouter())
    }
}
