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

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var dayAssigned: Date
}

#if DEBUG
let testDataTasks = [
    Task(title: "task 1", completed: false, dayAssigned: Date()),
    Task(title: "task 2", completed: true, dayAssigned: Date())
]
#endif
