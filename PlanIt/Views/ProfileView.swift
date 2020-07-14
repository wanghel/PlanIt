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
    
//    @State var profileVM: UserViewModel?
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
                ProfileMainView()
                
                
                if self.viewRouter.showSignIn {
//                    AuthView(profileVM: self.$profileVM)
                    AuthView()
                }
            }
            .frame(width: screenWidth)
//            .navigationBarTitle("\(self.viewRouter.showSignIn ? self.viewRouter.showSignUp ? "Sign up": "Sign In" : profileVM?.profile.userName?.lowercased() ?? "")", displayMode: .inline)
                .navigationBarTitle("\(self.viewRouter.showSignIn ? self.viewRouter.showSignUp ? "Sign up": "Sign In" : session.profileVM?.profile.userName?.lowercased() ?? "")", displayMode: .inline)
            .navigationBarItems(
                leading:
                    HStack {
                        
                        if !self.viewRouter.showSignIn {
                            NavigationLink(destination:
                                //Text("profile edit")
                                ProfileEditView()
                                .environmentObject(session)
                            ) {
                                Image(systemName: "pencil")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                                .opacity(0.9)
                                .padding([.bottom, .trailing])
                            }
                            
                        }
                },
                trailing:
                Button(action: {
                    self.viewRouter.viewProfile = false
                }){
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding(.bottom)
                })
        }
        .offset(x: viewRouter.viewProfile ? 0 : -screenWidth)
        .animation(.easeOut)
        .onAppear(perform: getUser)
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct ProfileMainView: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var userProfilesVM = UserProfilesViewModel()
    
    func getUser() {
        session.listen()
    }
    
    
    var body: some View {
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    Image(systemName: "person.crop.circle.fill").resizable()
                        .frame(width: 150, height: 150)
                    
                    Text(session.profileVM?.profile.name ?? "").font(.title)
                        .padding()
                    
                    Text(session.profileVM?.profile.bio ?? "").font(.body)
                        .padding()
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Friends")
                            Spacer()
                            Button(action: {}) {
                                Text("more")
                            }
                        }
                        
                        ForEach(session.profileVM?.friends ?? [], id: \.self) { friend in
                            NavigationLink(destination: UserProfilesView(friendProfile: UserViewModel(profile: friend)) ) {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                    Text("\(friend.name ?? "")")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                        }
                        
                    }
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding()
                .animation(.none)
            }
        }
        .onAppear(perform: getUser)
    }
}

struct ProfileEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State var userName: String = ""
    @State var name: String = ""
    @State var bio: String = ""
    
    func setValue() -> Void {
        userName = session.profileVM?.profile.userName ?? ""
        name = session.profileVM?.profile.name ?? ""
        bio = session.profileVM?.profile.bio ?? ""
    }
    
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Username")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("User Name", text: $userName)
                        .font(.system(size: 14))
                        .padding()
                        .background(navy.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Name")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("Name", text: $name)
                        .font(.system(size: 14))
                        .padding()
                        .background(navy.cornerRadius(10))
                        .frame(width: 270)
                }
                
                HStack {
                    Text("Bio")
                        .font(.system(size: 14))
                    Spacer()
                    TextField("Bio", text: $bio)
                        .font(.system(size: 14))
                        .padding()
                        .background(navy.cornerRadius(10))
                        .frame(width: 270)
                }
                
            }
            
            
        }
        .foregroundColor(.white)
        .onAppear(perform: setValue)
        .navigationBarItems(leading:
            Button(action: {
                self.goBack()
            }) {
                Text("Cancel")
                    .foregroundColor(.white)
            }, trailing:
            Button(action: {
                if let currUser = self.session.profileVM?.profile {
                    self.session.profileVM?.profile = User(id: currUser.id, email: currUser.email, userName: self.userName, name: self.name, bio: self.bio, friends: currUser.friends)
                }
                sleep(1)
                self.goBack()
            }) {
                Text("Done")
                    .foregroundColor(.white)
        })
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
            .environmentObject(SessionStore())
            .environmentObject(ViewRouter())

    }
}
