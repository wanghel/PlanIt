//
//  DataStore.swift
//  PlanIt
//
//  Created by Helen Wang on 5/30/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id : String
    var toDoItem : String
    var dateCreation : Date
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
