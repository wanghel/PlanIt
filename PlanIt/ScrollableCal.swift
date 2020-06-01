//
//  ScrollableCal.swift
//  PlanIt
//
//  Created by Helen Wang on 5/31/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

//import SwiftUI
//
//struct ScrollableCal: View {
//
//        @ObservedObject var listData = getData()
//        
//        var body: some View {
//            /*List(0..<listData.data.count, id: \.self) { idx in
//                
//                if(idx == 0){
//                    CalendarView(isFirst: true, isLast: false, listData: self.listData)
//                }
//                else if (idx == self.listData.data.count-1){
//                    CalendarView(isFirst: false, isLast: true, listData: self.listData)
//                } else {
//                    CalendarView(isFirst: false, isLast: false, listData: self.listData)
//                }
//                
//            }.padding(.horizontal, -20)*/
//            /*CalendarView(/*isFirst: false, isLast: false, listData: self.listData*/)*/
//            Text("hi")
//        }
//    
//}
//
//struct ScrollableCal_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollableCal()
//    }
//}
//
//struct Cal : Identifiable {
//    var id: Int
//    var currCal : CurrCalendar
//}
//
//class getData: ObservableObject {
//    @Published var data = [Cal]()
//    @Published var count = 1
//    
//    init() {
//        data = [Cal(id: 0, currCal: currCalendar)]
//    }
//    
//    func prevMonth() {
//        currCalendar.prevMonth()
//        data.insert(Cal(id: count+1, currCal: currCalendar), at: 0)
//        print(count)
//    }
//    
//    func nextMonth() {
//        currCalendar.nextMonth()
//        data.insert(Cal(id: count+1, currCal: currCalendar), at: count)
//        print(count)
//    }
//}
//
