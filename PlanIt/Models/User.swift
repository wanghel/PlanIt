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

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var email: String?
    var userName: String
    var firstName: String
    var lastName: String
    //var bio: String
    var friends: [String]
}

#if DEBUG


let testUser2 = User(
    id: "1",
    email: "madeup",
    userName: "euni",
    firstName: "Eunice",
    lastName: "Choi",
    //bio: "some Eunice bio",
    friends: []
)

let testUser3 = User(
    id: "3",
    email: "madeup",
    userName: "meridienmach",
    firstName: "Meridien",
    lastName: "Mach",
    //bio: "some Mer bio",
    friends: []
)

let testUser1 = User(
    id: "3",
    email: "madeup",
    userName: "helenwang1004",
    firstName: "Helen",
    lastName: "Wang",
    //bio: "some Helen bio",
    friends: [testUser2.userName, testUser3.userName]
)

#endif
