//
//  SignUpView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/16/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewControl: ViewControl
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    @State var userName: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @ObservedObject var userVM = UserViewModel()
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
            
        }
        
       userVM.addUser(user: User(email: email, userName: userName, firstName: firstName, lastName: lastName, friends: []))
        viewControl.dayTaskVM.taskRepository.reloadData()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create Account")
            Text("Sign up to get started")
            Spacer()
            
            VStack{
                TextField("Email address", text: $email)
                .font(.system(size: 14))
                .padding(12)
            SecureField("Password", text: $password)
                .font(.system(size: 14))
                .padding(12)
            
            TextField("User Name", text: $userName)
            .font(.system(size: 14))
            .padding(12)
            TextField("First Name", text: $firstName)
                .font(.system(size: 14))
                .padding(12)
            TextField("Last Name", text: $lastName)
            .font(.system(size: 14))
            .padding(12)
                
            }
            
            
            Button(action: {
                self.signUp()
            }) {
                Text("Create Account")
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("I'm a previous user")
                Text("Sign In")
                    .onTapGesture {
                        //NEED TO CHANGE
                        self.viewControl.showSignIn.toggle()
                        self.viewControl.showSignUp.toggle()
                }
            }
            
        }
        .background(Color.white)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
