//
//  EventStore.swift
//  PlanIt
//
//  Created by Helen Wang on 6/3/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import SwiftUI

struct Event : Identifiable {
    var id : Date
    var title : String
    var start : Date
    var end : Date
}

class EventStore : ObservableObject {
    @Published var events = [Event]()
}
