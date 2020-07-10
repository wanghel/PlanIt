//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine

//class UserViewModel: ObservableObject, Identifiable {
//    @Published var userProfileRepository = UserProfileRepository()
//    @Published var profile: UserProfile
//
////    @Published var friends: [UserProfile] = []
//
//    private var cancellables = Set<AnyCancellable>()
//
//    var id = ""
//
//    init(profile: UserProfile) {
//        print("created from USER VM")
//        self.profile = profile
//
//        $profile.compactMap { profile in
//            profile.id
//        }
//        .assign(to: \.id, on: self)
//        .store(in: &cancellables)
//
//        $profile
//            .dropFirst()
//            .debounce(for: 0.7, scheduler: RunLoop.main)
//            .sink { profile in
//                self.userProfileRepository.updateProfile(profile)
//        }
//        .store(in: &cancellables)
//
//
//    }
//
//}


class UserViewModel: ObservableObject, Identifiable {
    @Published var userProfileRepository = UserProfileRepository()
    @Published var profile: User
    
    @Published var friends = [User]()
    
    private var cancellables = Set<AnyCancellable>()
    
    var id = ""
  
    init(profile: User) {
//        print("created from USER VM")
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
                print("PROFILE CHANGED")
                self.userProfileRepository.updateProfile(profile)
                self.fetchFriendProfiles()
        }
        .store(in: &cancellables)
        
        
        fetchFriendProfiles()
    }
    
    func fetchFriendProfiles() {
        self.friends.removeAll()
        for friend in profile.friends ?? [] {
            self.userProfileRepository.fetchProfile(userId: friend) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    return
                }
//                print("fetched friend \(profile)")
                if let profile = profile {
                    self.friends.append(profile)
                }
            }
        }
        
    }
    
}
