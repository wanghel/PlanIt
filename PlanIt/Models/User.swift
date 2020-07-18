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
    var name: String?
    var bio: String?
    var friends: [String]?
    var isPrivate: Bool?
}

#if DEBUG


let testUser2 = User(
    id: "2",
    userName: "euni",
    name: "Eunice",
    bio: "some Eunice bio",
    friends: []
)

let testUser3 = User(
    id: "3",
    userName: "meridienmach",
    name: "Meridien",
    bio: "some Mer bio",
    friends: ["1"]
)

let testUser1 = User(
    id: "1",
    userName: "helenwang1004",
    name: "Helen",
    bio: "some Helen bio",
    friends: ["3"]
)

#endif
