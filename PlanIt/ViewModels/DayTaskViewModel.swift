//
//  DayEventsViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine
import Firebase

class DayTaskViewModel: ObservableObject {
    //@Published var taskRepository : TaskRepository
    @Published var session = SessionStore()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        session.taskRepository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        session.taskRepository.addTask(task)
    }
    
    func deleteTask(task: Task) {
        session.taskRepository.deleteTask(task)
    }
}
