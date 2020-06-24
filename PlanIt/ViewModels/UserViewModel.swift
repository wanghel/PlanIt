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
    @Published var userRepository = UserProfileRepository()
    @Published var profile: UserProfile
    
    private var cancellables = Set<AnyCancellable>()
    
  
    init(profile: UserProfile) {
        self.profile = profile
        $profile
            .dropFirst()
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .sink { profile in
                self.userRepository.updateProfile(profile)
        }
        .store(in: &cancellables)
    }

}
