//
//  AuthView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/16/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            
            SignInView()
            
            if viewRouter.showSignUp {
                SignUpView()
                .transition(.opacity)
                .animation(.default)
            }
        }
        .padding(.horizontal)
    }
}

struct SignInView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
            else {
                self.email = ""
                self.password = ""
                self.session.profileVM = UserViewModel(profile: result ?? User(id: ""))
                self.viewRouter.showSignIn.toggle()
            }
        }
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "envelope")
                    .font(.system(size: 20))
                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.system(size: 14))
                    .padding()
                
            }
            .padding(.horizontal)
            .background(darkBackground.cornerRadius(10))
            
            
            HStack {
                Image(systemName: "lock")
                    .font(.system(size: 20))
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding()
            }
            .padding(.horizontal)
            .background(darkBackground.cornerRadius(10))
            
            Button(action: {
                self.signIn()
            }) {
                HStack {
                    Spacer()
                    Text("SIGN IN")
                    .font(.system(size: 15))
                    Spacer()
                }
                    .padding()
                .background(Color.blue.cornerRadius(10).opacity(0.5))
            }
            .padding(50)
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            
            Spacer()
            HStack {
                Text("I'm a new user")
                .font(.system(size: 20))
                Text("Create new account")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.viewRouter.showSignUp.toggle()
                }
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(darkerBackground)
    }
}

struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var error: String = ""
    
    @State var userName: String = ""
    @State var name: String = ""
    @State var bio: String = ""
    
    
    @ObservedObject var userProfilesVM = UserProfilesViewModel()
    
    func signUp() {
        var completeSignUp = true
        
        for profile in userProfilesVM.userVM {
            if profile.profile.userName?.lowercased() == userName.lowercased() {
                self.error = "Username already taken. Please choose another username."
                completeSignUp = false
            }
        }
        
        if password != confirmPassword {
            self.error = "Passwords don't match. Please confirm your password again."
            completeSignUp = false
        }
        
        if completeSignUp {
            session.signUp(email: email, password: password, userName: userName, name: name, bio: bio) { (result, error) in
                if let error = error {
                    self.error = error.localizedDescription
                } else {
                    self.email = ""
                    self.password = ""
                    self.session.profileVM = UserViewModel(profile: result ?? User(id: ""))
                    self.viewRouter.showSignIn.toggle()
                    self.viewRouter.showSignUp.toggle()
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text("Email")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("Email address", text: $email)
                        .textContentType(.emailAddress)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Password")
                        .font(.system(size: 14))
                    Spacer()
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Confirm Password")
                        .font(.system(size: 14))
                    Spacer()
                    SecureField("Confirm Password", text: $confirmPassword)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Username")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("User Name", text: $userName)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Name")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("Name", text: $name)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Bio")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("Bio", text: $bio)
                        .font(.system(size: 14))
                        .padding()
                        .background(darkBackground.cornerRadius(10))
                        .frame(width: 270)
                }
            }
            
            Button(action: {
                self.signUp()
            }) {
                HStack {
                    Spacer()
                    Text("Create Account")
                        .font(.system(size: 15))
                    Spacer()
                }
                .padding()
                .background(Color.blue.cornerRadius(10).opacity(0.5))
            }
            .padding(50)
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("I'm a previous user")
                    .font(.system(size: 20))
                Text("Sign In")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.viewRouter.showSignUp.toggle()
                }
            }
            
        }
        .padding()
        .foregroundColor(.white)
        .background(darkerBackground)
        
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
//        SignInView(profileVM: .constant(UserViewModel(profile: testUser2)))
//        .environmentObject(ViewRouter())
        ContentView()
    }
}
#endif
