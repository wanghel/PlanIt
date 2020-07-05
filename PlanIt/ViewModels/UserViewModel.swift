//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {
    @Published var userProfileRepository = UserProfileRepository()
    @Published var profile: UserProfile
    
//    @Published var friends: [UserProfile] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    var id = ""
  
    init(profile: UserProfile) {
        print("created from USER VM")
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
    
//    func addFriend (userProfile: UserProfile?) {
//        print(profile.userName)
//        print(userProfile!.userName)
//        if let userProfile = userProfile {
//            userProfileRepository.addFriend(userProfile, friendProfile: profile)
//        } else {
//            print("error adding friends")
//        }
//    }
    
}
