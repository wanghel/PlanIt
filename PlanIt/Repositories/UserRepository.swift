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

class UserRepository: ObservableObject {
    
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    
    @Published var users = [User]()
    @Published var user: User = User(
        id: "",
        email: "",
        userName: "",
        firstName: "",
        lastName: "",
        friends: []
    )
    
    init() {
        loadData()
    }
    
    func loadData() {
        if userId != nil {
            db.collection("users")
                .document(userId!)
                .getDocument() { (document, error) in
                    let result = Result {
                        try document?.data(as: User.self)
                    }
                    switch result {
                    case .success(let user):
                        if let user = user {
                            // A `User` value was successfully initialized from the DocumentSnapshot.
                            print("User: \(String(describing: user.id))")
                            self.user = user
                        } else {
                            // A nil value was successfully initialized from the DocumentSnapshot,
                            // or the DocumentSnapshot was nil.
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        // A `City` value could not be initialized from the DocumentSnapshot.
                        print("Error decoding user: \(error)")
                    }
            }
        }
        
        db.collection("users")
            .addSnapshotListener { (querySnapshot, error) in
                if let qs = querySnapshot {
                    self.users = qs.documents.compactMap {
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
    
    func addUser(_ user: User) {
        do {
            let _ = try db.collection("users").document(user.userName).setData(from: user)
        }
        catch {
            fatalError("Unable to encode user: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ user: User) {
        if let userID = user.id {
            do {
                try db.collection("users").document(userID).setData(from: user)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
}
