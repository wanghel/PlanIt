//
//  SIgnInView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/16/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var profile: UserProfile?
    
    var body: some View {
        ZStack {
            
            SignInView(profile: $profile)
            
            if viewRouter.showSignUp {
                SignUpView(profile: $profile)
                .transition(.opacity)
                .animation(.default)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! * 2)
    }
}

struct SignInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    @Binding var profile: UserProfile?
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
            else {
                self.email = ""
                self.password = ""
                self.profile = result
                self.viewRouter.showSignIn.toggle()
            }
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Sign In to continue")
            Spacer()
            
            HStack {
                Text("Email")
                    .font(.system(size: 14))
                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.system(size: 14))
                    .padding()
            }
            HStack {
                Text("Password")
                    .font(.system(size: 14))
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding()
            }
            Button(action: {
                self.signIn()
            }) {
                Text("Sign In")
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            
            Spacer()
            HStack {
                Text("I'm a new user")
                Text("Create new account")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.viewRouter.showSignUp.toggle()
                }
            }
        }
        .foregroundColor(.white)
        .background(dnavy)
    }
}

struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    @State var userName: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @Binding var profile: UserProfile?
    
    //@ObservedObject var userVM = UserViewModel()
    
    func signUp() {
        session.signUp(email: email, password: password, userName: userName, firstName: firstName, lastName: lastName) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                self.profile = result
                self.viewRouter.showSignIn.toggle()
                self.viewRouter.showSignUp.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Sign up to get started")
            Spacer()
            
            VStack{
                HStack {
                    Text("Email")
                    .font(.system(size: 14))
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .font(.system(size: 14))
                        .padding()
                        .background(navy)
                }
                HStack {
                    Text("Password")
                    .font(.system(size: 14))
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding()
                }
                HStack {
                    Text("User Name")
                    .font(.system(size: 14))
                    TextField("User Name", text: $userName)
                        .font(.system(size: 14))
                        .padding()
                }
                HStack {
                    Text("First Name")
                    .font(.system(size: 14))
                    TextField("First Name", text: $firstName)
                        .font(.system(size: 14))
                        .padding()
                }
                HStack {
                    Text("Last Name")
                    .font(.system(size: 14))
                    TextField("Last Name", text: $lastName)
                        .font(.system(size: 14))
                        .padding()
                }
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
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.viewRouter.showSignUp.toggle()
                }
            }
            
        }
        .foregroundColor(.white)
        .background(dnavy)
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(profile: .constant(testUser2))
    }
}
