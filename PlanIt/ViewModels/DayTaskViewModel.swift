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
    @Published var taskRepository = SessionStore().taskRepository
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
    }
    
    func updateTask(task: Task) {
        taskRepository.updateTask(task)
    }
    
    func deleteTask(task: Task) {
        taskRepository.deleteTask(task)
    }
}
