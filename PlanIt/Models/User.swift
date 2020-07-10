//
//  User.swift
//  PlanIt
//
//  Created by Helen Wang on 6/22/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable {
//    var uid: String
    var id: String
    var email: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    
    var friends: [String]?
    
//    static func ==(lhs: User, rhs: User) -> Bool {
//        return lhs.id == rhs.id
//    }
}

#if DEBUG


let testUser2 = User(
    id: "2",
    userName: "euni",
    firstName: "Eunice",
    lastName: "Choi",
    //bio: "some Eunice bio",
    friends: []
)

let testUser3 = User(
    id: "3",
    userName: "meridienmach",
    firstName: "Meridien",
    lastName: "Mach",
    //bio: "some Mer bio",
    friends: ["1"]
)

let testUser1 = User(
    id: "1",
    userName: "helenwang1004",
    firstName: "Helen",
    lastName: "Wang",
    //bio: "some Helen bio",
//    friends: [testUser2, testUser3]
    friends: ["3"]
)

#endif
