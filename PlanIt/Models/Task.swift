//
//  Task.swift
//  PlanIt
//
//  Created by Helen Wang on 6/15/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TaskPriority: Int, Codable {
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
}

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String?
    var title: String
    var description: String
    var priority: TaskPriority
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var dayAssigned: Date
}

#if DEBUG
let testDataTasks = [
    Task(title: "task 1", description: "", priority: TaskPriority.high, completed: false, dayAssigned: Date()),
    Task(title: "task 2", description: "", priority: TaskPriority.low, completed: true, dayAssigned: Date())
]

let emptyTask = Task(title: "", description: "", priority: TaskPriority.none, completed: false, dayAssigned: Date())
#endif
