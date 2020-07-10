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
    @Published var isLoggedIn: Bool?
    
    private var profileRepository = UserProfileRepository()
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    
//    @Published var profile: UserProfile? {
//        didSet {
//            self.didChange.send(self)
//        }
//    }
    
    @Published var profile: User? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    
//    @Published var friendProfiles: [UserProfile]?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        print("made another session store")
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
//                self.profile = UserProfile(id: user.uid, userName: "", firstName: "", lastName: "", friends: [])
                self.profile = User(id: user.uid, userName: "", firstName: "", lastName: "", friends: [])
            }
            else {
                self.session = nil
            }
        })
    }
    
//    func signUp(email: String, password: String, userName: String, firstName: String, lastName: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                print("Error signing up: \(error)")
//                completion(nil, error)
//                return
//            }
//
//            guard let user = result?.user else { return }
//            print("User \(user.uid) signed up.")
//
//            let userProfile = UserProfile(id: user.uid, userName: userName.lowercased(), firstName: firstName, lastName: lastName, friends: [])
//
//            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
//                if let error = error {
//                    print("Error while fetching the user profile: \(error)")
//                    completion(nil, error)
//                    return
//                }
//                self.profile = profile
//                completion(profile, nil)
//            }
//        }
//    }
//
//    func signIn(email: String, password: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                print("Error signing in: \(error)")
//                completion(nil, error)
//                return
//            }
//
//            guard let user = result?.user else { return }
//            print("User \(user.uid) signed in.")
//
//            self.profileRepository.fetchProfile(userId: user.uid) { (profile, error) in
//                if let error = error {
//                    print("Error while fetching the user profile: \(error)")
//                    completion(nil, error)
//                    return
//                }
//
//                self.profile = profile
//
//                completion(profile, nil)
//            }
//        }
//    }
    
    func signUp(email: String, password: String, userName: String, firstName: String, lastName: String, completion: @escaping (_ profile: User?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing up: \(error)")
                completion(nil, error)
                return
            }
            
            guard let user = result?.user else { return }
            print("User \(user.uid) signed up.")
            
            let userProfile = User(id: user.uid, userName: userName.lowercased(), firstName: firstName, lastName: lastName, friends: [])
            
            self.profileRepository.createProfile(profile: userProfile) { (profile, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                self.profile = profile
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
                
                self.profile = profile
                
                completion(profile, nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            Auth.auth().signInAnonymously()
            self.session = nil
            self.profile = nil
        }
        catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    
    func updateProfile() {
        if let profile = profile {
            do {
                profileRepository.updateProfile(profile)
            }
        }
    }
    
    
}
