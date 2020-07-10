//
//  TaskCellViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository: TaskRepository
    
    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(task: Task, taskRepository: TaskRepository) {
//        print("created from TASK CELL VM")
        self.task = task
        self.taskRepository = taskRepository
        
        $task.map { task in
            task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
        
        $task.compactMap { task in
            task.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        
        $task
            .dropFirst()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task)
        }
        .store(in: &cancellables)
    }
    
}
