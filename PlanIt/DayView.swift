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
    var body: some View {
        Text("Hello, \(day)")
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: 1)
    }
}
