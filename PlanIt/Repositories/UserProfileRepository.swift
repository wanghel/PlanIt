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
    //let userId = Auth.auth().currentUser?.uid
    
    func createProfile(profile: UserProfile, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
      do {
        let _ = try db.collection("users").document(profile.id).setData(from: profile)
        completion(profile, nil)
      }
      catch let error {
        print("Error creating profile: \(error)")
        completion(nil, error)
      }
    }
    
    func fetchProfile(userId: String, completion: @escaping (_ profile: UserProfile?, _ error: Error?) -> Void) {
      db.collection("users").document(userId).getDocument { (snapshot, error) in
        let profile = try? snapshot?.data(as: UserProfile.self)
        completion(profile, error)
      }
    }
    
    func updateProfile(_ userProfile: UserProfile) {
        
        do {
            try db.collection("users").document(userProfile.id).setData(from: userProfile)
        }
        catch {
            fatalError("Unable to encode user: \(error.localizedDescription)")
        }
        
    }
}
