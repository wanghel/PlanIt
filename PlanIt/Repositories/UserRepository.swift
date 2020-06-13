//
//  UserRepository.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var users = [User]()
    
    func loadData() {
        db.collection("users").addSnapshotListener{ (querySnapshot, error) in
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
}
