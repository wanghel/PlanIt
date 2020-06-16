//
//  ViewControl.swift
//  PlanIt
//
//  Created by Helen Wang on 6/15/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class ViewControl: ObservableObject {
    @Published var selected = 1
    @Published var viewProfile = false
    @Published var isShowingDayView = true
    @Published var dateShown = Date()
    @Published var showSignIn = true
}
