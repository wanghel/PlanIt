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
    //@Published var userRepository = UserRepository()
    @Published var userProfile: UserProfile?
    
    private var cancellables = Set<AnyCancellable>()
  
//    init() {
//        self.userP = userRepository.user
//    }
//
//    func addUser(user: User) {
//        userRepository.addUser(user)
//    }
}
