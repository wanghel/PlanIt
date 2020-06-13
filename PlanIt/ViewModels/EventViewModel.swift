//
//  EventViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class EventViewModel: ObservableObject, Identifiable {
    @Published var event: Event
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(event: Event) {
        self.event = event
        
        $event.map { event in
            event.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
    
    func duration() -> Double {
        return event.endTime.distance(to: event.beginTime)
    }
    
    
    
    
    
}
