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
                    Text("This Week's Tasks")
                        .padding()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    TaskView(showWeek: true)
                }
                
            }
            .navigationBarTitle("PlanIt", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.viewRouter.viewProfile = true
                }){
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.7)
                        .padding(.bottom)
                }, trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.7)
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
    }
}
