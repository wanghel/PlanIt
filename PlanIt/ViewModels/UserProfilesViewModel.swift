//
//  UserProfilesViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 7/1/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class UserProfilesViewModel : ObservableObject {
    @Published var userProfileRepository: UserProfileRepository //= UserProfileRepository()
    @Published var userVM = [UserViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userProfileRepository: UserProfileRepository) {
        self.userProfileRepository = userProfileRepository
//        print("created from USER PROFILES VM")
        userProfileRepository.$userProfiles.map { profiles in
            profiles.map { profile in
                UserViewModel(profile: profile, userProfileRepository: userProfileRepository)
            }
        }
        .assign(to: \.userVM, on: self)
        .store(in: &cancellables)
    }
    
    
}

