//
//  UserViewModel.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Combine
import UIKit

class UserViewModel: ObservableObject, Identifiable {
    
    @Published var userProfileRepository = UserProfileRepository()
    @Published var profile: User
    @Published var profilePic: UIImage?
    @Published var friends = [User]()
    
    private var cancellables = Set<AnyCancellable>()
    
    var didChange = PassthroughSubject<[User], Never>()
    
    var id = ""
  
    init(profile: User) {
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
                if let profile = profile {
                    self.friends.append(profile)
                }
            }
        }

    }
    
    
    func fetchProfilePic() {
        self.userProfileRepository.fetchImage(profile.id) {
            (image, error) in
            if let error = error {
                print("Error while fetching user profile picture: \(error.localizedDescription)")
            }

            if let image = image {
                print("set image")
                self.profilePic = image
            }
        }
    }
    
}
