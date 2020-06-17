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
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: Usertemp? {
        didSet {
            self.didChange.send(self)
        }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = Usertemp(uid: user.uid, email: user.email)
            }
            else {
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}


struct Usertemp {
    var uid: String
    var email: String?
}

