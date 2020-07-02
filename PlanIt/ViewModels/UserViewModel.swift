//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable{
    @Published var userProfileRepository = UserProfileRepository()
    @Published var profile: UserProfile
    
    private var cancellables = Set<AnyCancellable>()
    
    var id = ""
  
    init(profile: UserProfile) {
        self.profile = profile
        
        $profile.compactMap { profile in
            profile.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        
        $profile
            .dropFirst()
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .sink { profile in
                self.userProfileRepository.updateProfile(profile)
        }
        .store(in: &cancellables)
    }

}
