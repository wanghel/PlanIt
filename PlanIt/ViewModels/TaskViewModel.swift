//
//  TaskViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/27/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine
import Firebase

class TaskViewModel: ObservableObject {
//    @Published var taskRepository = SessionStore().taskRepository
    @Published var taskRepository: TaskRepository //= TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
        print("created from TASK VM")
        taskRepository.$tasks.map { tasks in
            tasks.map { task in
                TaskCellViewModel(task: task, taskRepository: taskRepository)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
    }
    
    func deleteTask(task: Task) {
        taskRepository.deleteTask(task)
    }
}
