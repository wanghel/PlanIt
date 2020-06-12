//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation

class UserViewModel: ObservableObject{
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
