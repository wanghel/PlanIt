//
//  UserRepository.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift


class UserProfileRepository: ObservableObject {
    @Published var userProfiles = [User]()
    
    let db = Firestore.firestore()
    
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
    
        
    func fetchImage(_ id: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
            let ref = Storage.storage().reference(withPath: "images/\(id).jpg")
            print("get image: images/\(id).jpg")
            ref.getData(maxSize: 4 * 1024 * 1024) { data, error in
                completion(UIImage(data: data ?? Data()), error)
            }
            
        }
    
    func updateImage(_ id: String, _ image: UIImage?) {
        if let image = image {
            let data = image.pngData()
            
            let ref = Storage.storage().reference().child("images/\(id).jpg")
            
            if let data = data {
                print("changed picture")
                ref.putData(data, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
    }
}
