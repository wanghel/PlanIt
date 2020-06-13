//
//  Event.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

struct Event: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var color: String
    var beginTime: Date
    var endTime: Date
    var location: String
    var notes: String
}

#if DEBUG
let testEvents = [testEvent, testEvent2]

let testEvent = Event(
    title: "App due super long title testing",
    color: "red",
    beginTime: Date(),
    endTime: Date(timeIntervalSinceNow: TimeInterval(3600)),
    location: "My house",
    notes: "some notes"
)

let testEvent2 = Event(
    title: "Sleep",
    color: "green",
    beginTime: Date(timeIntervalSinceNow: TimeInterval(3900)),
    endTime: Date(timeIntervalSinceNow: TimeInterval(9000)),
    location: "My bed",
    notes: "some notes about sleeping"
)

#endif

