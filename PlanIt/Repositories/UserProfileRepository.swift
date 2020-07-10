//
//  UserRepository.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserProfileRepository: ObservableObject {
    

    let db = Firestore.firestore()
    
//    @Published var userProfiles = [UserProfile]()
    @Published var userProfiles = [User]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("users")
            .order(by: "userName")
            .addSnapshotListener { (querySnapshot, error) in
                if let qs = querySnapshot {
                    self.userProfiles = qs.documents.compactMap {
                        document in
                        do {
//                            let x = try document.data(as: UserProfile.self)
                            let x = try document.data(as: User.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
                
        }
    }
    
    
//    func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
//        do {
//            let _ = try self.db.collection("users").document(profile.id).setData(from: profile)
//            completion(profile, nil)
//        }
//        catch let error {
//            print("Error creating profile: \(error)")
//            completion(nil, error)
//        }
//    }
//
//    func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
//        db.collection("users").document(userId).getDocument { (snapshot, error) in
//            let profile = try? snapshot?.data(as: UserProfile.self)
//            completion(profile, error)
//        }
//    }
//
//    func updateProfile(_ userProfile: UserProfile) {
//        do {
//            try db.collection("users").document(userProfile.id).setData(from: userProfile)
//        }
//        catch {
//            fatalError("Unable to encode user: \(error.localizedDescription)")
//        }
//    }
    
    func createProfile(profile: User, completion: @escaping (_ profile: User?, _ error: Error?) -> Void) {
          do {
              let _ = try self.db.collection("users").document(profile.id).setData(from: profile)
              completion(profile, nil)
          }
          catch let error {
              print("Error creating profile: \(error)")
              completion(nil, error)
          }
      }
      
      func fetchProfile(userId: String, completion: @escaping (_ profile: User?, _ error: Error?) -> Void) {
          db.collection("users").document(userId).getDocument { (snapshot, error) in
              let profile = try? snapshot?.data(as: User.self)
              completion(profile, error)
          }
      }
    
      func updateProfile(_ userProfile: User) {
          do {
              try db.collection("users").document(userProfile.id).setData(from: userProfile)
          }
          catch {
              fatalError("Unable to encode user: \(error.localizedDescription)")
          }
      }
    
}
