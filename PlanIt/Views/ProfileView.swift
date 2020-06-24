//
//  ProfileView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    //@State var person: UserProfile = testUser1
    @State var profile: UserProfile?
    @State var editingProfile = false
    @State var newProfile = UserProfile(id: "", userName: "", firstName: "", lastName: "", friends: [])
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        ZStack {
            // Profile view main
            ScrollView {
                if editingProfile {
                    ProfileEditView(newProfile: $newProfile, editingProfile: $editingProfile)
                } else {
                    ProfileMainView(profile: self.$profile)
                }
            }
            .frame(width: screenWidth)
            .background(Color.white)
            .padding(.top, 60)
            
            if self.viewRouter.showSignIn {
                AuthView(profile: self.$profile)
                    .padding(.top, 60)
            }
            
            ProfileBarView(profile: $profile, newProfile: $newProfile, editingProfile: $editingProfile)
                .edgesIgnoringSafeArea(.top)
            
        }
        .offset(y: viewRouter.viewProfile ? 0 : screenHeight)
        .animation(.default)
        .onAppear(perform: getUser)
        
    }
}

struct ProfileMainView: View {
    @Binding var profile: UserProfile?
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            
            Image(systemName: "person.crop.circle.fill").resizable().frame(width: 150, height: 150)
            HStack {
                Text(profile?.firstName ?? "").font(.title)
                Text(profile?.lastName ?? "").font(.title)
            }
            .padding()
//            Spacer()
//            Text(person.bio)
//            Spacer()
            VStack (alignment: .leading) {
                HStack {
                    Text("Friends")
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {}) {
                        Text("more")
                            .foregroundColor(.gray)
                    }
                }
                ForEach(profile?.friends ?? [], id: \.self) { friend in
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text(friend.userName)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .animation(.none)
    }
}

struct ProfileBarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @Binding var profile: UserProfile?
    @Binding var newProfile: UserProfile
    @Binding var editingProfile: Bool
    
    var body: some View {
        
        VStack  {
            Group {
                if !self.viewRouter.showSignIn {
                    
                    HStack {
                        Button(action: {
                            self.viewRouter.viewProfile = false
                            print(screenHeight)
                        }){
                            Image(systemName: "chevron.down")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                                .opacity(0.7)
                        }
                        Text(profile?.userName ?? "")
                            .font(.system(size: 25))
                            .opacity(0.7)
                            .padding(.horizontal)
                        Spacer()
                        Button(action: {
                            self.editingProfile.toggle()
                        }){
                            Image(systemName: "pencil")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                                .opacity(0.7)
                                .padding()
                        }
                        Button(action: {
                            self.session.signOut()
                            self.profile = UserProfile(id: "", userName: "", firstName: "", lastName: "", friends: [])
                            self.viewRouter.showSignIn.toggle()
                        }){
                            Image(systemName: "gear")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                                .opacity(0.7)
                        }
                    }
                    
                } else {
                    AuthBarView()
                        .animation(.none)
                }
            }
            .frame(height: 60)
            .padding(.horizontal)
            .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.white)
            .clipped()
            
            Spacer()
            
        }
        
        
    }
}

struct ProfileEditView: View {
    @Binding var newProfile: UserProfile
    @Binding var editingProfile: Bool
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            
            //            Text("Test change name")
            //            .onTapGesture {
            //                self.session.profile?.firstName = "Not Helen"
            //                self.session.updateProfile()
            //            }
            
            Image(systemName: "person.crop.circle.fill").resizable().frame(width: 150, height: 150)
            HStack {
                TextField("Enter First Name", text: $newProfile.firstName)
                TextField("Enter Last Name", text: $newProfile.lastName)
            }
            //            Spacer()
            //            Text(person.bio)
            //            Spacer()
            VStack (alignment: .leading) {
                HStack {
                    Text("Friends")
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {}) {
                        Text("more")
                            .foregroundColor(.gray)
                    }
                }
                ForEach(newProfile.friends, id: \.self) { friend in
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text(friend.userName)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .animation(.none)
    }
}


struct AuthBarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        HStack {
            Button(action: {
                self.viewRouter.viewProfile = false
                print(screenHeight)
            }){
                Image(systemName: "chevron.down")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            Text(self.viewRouter.showSignUp ? "Create Account" : "Sign In")
                .font(.system(size: 25))
                .opacity(0.7)
                .padding(.horizontal)
            Spacer()
        }
        
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView(profile: .constant(testUser1)).environmentObject(SessionStore())
        //ContentView()
    }
}
