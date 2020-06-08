//
//  DayView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/1/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct DayView: View {
    var day: Int
    var month : Int
    var year : Int
    var date : Date
    
    init (day: Int, month: Int, year: Int) {
        self.day = day
        self.month = day
        self.year = year
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        self.date = Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        Text("Hello, \(day)")
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: 1, month: 1, year: 2020)
    }
}
