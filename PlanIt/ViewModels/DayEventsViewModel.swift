//
//  DayEventsViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class DayEventsViewModel: ObservableObject {
    @Published var eventViewModels = [EventViewModel]()
    
    init() {
        self.eventViewModels = testEvents.map { event in
            EventViewModel(event: event)
        }
    }
}
