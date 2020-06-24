//
//  User.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile: Codable, Identifiable, Hashable {
    var id: String
    var userName: String
    var firstName: String
    var lastName: String
    //var bio: String
    var friends: [UserProfile]
}

#if DEBUG


let testUser2 = UserProfile(
    id: "1",
    userName: "euni",
    firstName: "Eunice",
    lastName: "Choi",
    //bio: "some Eunice bio",
    friends: []
)

let testUser3 = UserProfile(
    id: "3",
    userName: "meridienmach",
    firstName: "Meridien",
    lastName: "Mach",
    //bio: "some Mer bio",
    friends: []
)

let testUser1 = UserProfile(
    id: "3",
    userName: "helenwang1004",
    firstName: "Helen",
    lastName: "Wang",
    //bio: "some Helen bio",
    friends: [testUser2, testUser3]
)

#endif