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
    
    //@State var profile: UserProfile? = testUser1
    @State var profile: UserProfile?
//    @State var profileVM: UserViewModel?
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
                    ProfileMainView(profile: self.$profile)
//                ProfileMainView(profileVM: self.$profileVM)
                
                
                if self.viewRouter.showSignIn {
                    AuthView(profile: self.$profile)
//                    AuthView(profileVM: self.$profileVM)
                }
            }
            .frame(width: screenWidth)
            .navigationBarTitle("\(self.viewRouter.showSignIn ? self.viewRouter.showSignUp ? "Sign up": "Sign In" : profile?.userName.lowercased() ?? "")", displayMode: .inline)
//                .navigationBarTitle("\(self.viewRouter.showSignIn ? self.viewRouter.showSignUp ? "Sign up": "Sign In" : profileVM?.profile.userName.lowercased() ?? "")", displayMode: .inline)
            .navigationBarItems(
                leading:
                    HStack {
                        if !self.viewRouter.showSignIn {
                            Button(action: {
                                
                            }){
                                Image(systemName: "pencil")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                    .opacity(0.9)
                                    .padding([.bottom, .trailing])
                            }
                            
                            Button(action: {
                                self.session.signOut()
                                self.profile = UserProfile(id: "", userName: "", firstName: "", lastName: "", friends: [])
//                                self.profileVM = UserViewModel(profile: UserProfile(id: "", userName: "", firstName: "", lastName: ""))
                                self.viewRouter.showSignIn.toggle()
                            }){
                                Image(systemName: "delete.right")
                                    .frame(width: 1, height: 1)
                                    .foregroundColor(.white)
                                    .opacity(0.9)
                                    .padding([.bottom, .leading])
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
        
    }
    
}

struct ProfileMainView: View {
    @Binding var profile: UserProfile?
//    @Binding var profileVM: UserViewModel?
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
            VStack {
                
                Image(systemName: "person.crop.circle.fill").resizable()
                    .frame(width: 150, height: 150)
                
                HStack {
                    Text(profile?.firstName ?? "").font(.title)
                    Text(profile?.lastName ?? "").font(.title)
//                    Text(profileVM?.profile.firstName ?? "").font(.title)
//                    Text(profileVM?.profile.lastName ?? "").font(.title)
                }
                .padding()
                
                VStack (alignment: .leading) {
                    HStack {
                        Text("Friends")
                        Spacer()
                        Button(action: {}) {
                            Text("more")
                        }
                    }
//                    ForEach(profile?.friends ?? [], id: \.self) { friendID in
//                        Button(action: {}) {
//                            HStack {
//                                Image(systemName: "person.crop.circle.fill")
//                                Text(friend.userName)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.gray)
//                            }
//                            .padding()
//                        }
//                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .animation(.none)
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView(profile: .constant(testUser1))
            .environmentObject(SessionStore())
            .environmentObject(ViewRouter())
//        ProfileMainView(profileVM: .constant(UserViewModel(profile: testUser1)))
//        .environmentObject(SessionStore())
//        .environmentObject(ViewRouter())
    }
}
