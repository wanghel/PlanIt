//
//  SessionStore.swift
//  PlanIt
//
//  Created by Helen Wang on 6/16/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Firebase
import Combine

class SessionStore: ObservableObject {
    @Published var session: User?
//    @Published var isLoggedIn: Bool?
    
    @Published var profileVM: UserViewModel? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    private var profileRepository = UserProfileRepository()
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        print("made another session store")
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
                    if let error = error {
                        print("Error while fetching the user profile: \(error)")
                        self.profileVM = UserViewModel(profile: User(id: user.uid))
                    }
                    
                    if let profile = profile {
                        self.profileVM = UserViewModel(profile: profile)
                    }
                }
                print(user.uid)
                
            }
            else {
                self.session = nil
            }
        })
    }
    
    
    func signUp(email: String, password: String, userName: String, name: String, bio: String, completion: @escaping (_ profile: User?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing up: \(error)")
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed up.")
            
            let userProfile = User(id: user.uid, userName: userName.lowercased(), name: name, bio: bio, friends: [])
            
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                if let profile = profile {
                    self.profileVM = UserViewModel(profile: profile)
                }
                completion(profile, nil)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (_ profile: User?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing in: \(error)")
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed in.")
            
            self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                
                if let profile = profile {
                    self.profileVM = UserViewModel(profile: profile)
                }
                
                completion(profile, nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            Auth.auth().signInAnonymously()
            self.session = nil
            self.profileVM = nil
        }
        catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    
    
}
