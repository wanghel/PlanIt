//
//  ViewControl.swift
//  PlanIt
//
//  Created by Helen Wang on 6/15/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Firebase

class ViewRouter: ObservableObject {
    @Published var selected = 1
    @Published var viewProfile = false
    @Published var isShowingDayView = true
    @Published var dateShown = Date()//Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date()))!
    @Published var showSignIn = Auth.auth().currentUser!.isAnonymous //true
    @Published var showSignUp = false
}
