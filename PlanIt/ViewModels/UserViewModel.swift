//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class UserViewModel: ObservableObject{
    @Published var userRepository = UserRepository()
    @Published var user: User
    
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User) {
        
        self.user = user
    }
}
