//
//  Task.swift
//  PlanIt
//
//  Created by Helen Wang on 6/15/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
    var dateCreated: Date = Date()
    var dayAssigned: Date
}

#if DEBUG
let testDataTasks = [
    Task(title: "task 1", completed: false, dayAssigned: Date()),
    Task(title: "task 2", completed: true, dayAssigned: Date())
]
#endif
