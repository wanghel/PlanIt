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
    
    @State var profileVM: UserViewModel?
    
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
                    AuthView(profileVM: self.$profileVM)
                }
            }
            .frame(width: screenWidth)
            .navigationBarTitle("\(self.viewRouter.showSignIn ? self.viewRouter.showSignUp ? "Sign up": "Sign In" : profileVM?.profile.userName?.lowercased() ?? "")", displayMode: .inline)
            .navigationBarItems(
                leading:
                    HStack {
                        if !self.viewRouter.showSignIn {
//                            Button(action: {
//
//                            }){
//                                Image(systemName: "pencil")
//                                    .font(.system(size: 25))
//                                    .foregroundColor(.white)
//                                    .opacity(0.9)
//                                    .padding([.bottom, .trailing])
//                            }
                            
                            Button(action: {
                                self.session.signOut()
                                self.profileVM = UserViewModel(profile: User(id: ""))
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
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var userProfilesVM = UserProfilesViewModel()
    
    var body: some View {
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
            VStack {
                
                Image(systemName: "person.crop.circle.fill").resizable()
                    .frame(width: 150, height: 150)
                
                HStack {
                    Text(session.profileVM?.profile.firstName ?? "").font(.title)
                    Text(session.profileVM?.profile.lastName ?? "").font(.title)
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
                    
                    ForEach(session.profileVM?.friends ?? [], id: \.self) { friend in
                        NavigationLink(destination: Text(friend.userName ?? "")) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                Text("\(friend.firstName ?? "") \(friend.lastName ?? "")")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    
                }
                Spacer()
                
//                Button(action: {
//                    print("method 1 :\(self.session.profileVM?.profile.friends!)")
//                    print("method 2 :\(self.session.profileVM?.friends)")
//                }) {
//                    Text("PRESS")
//                }
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
        ProfileMainView()
            .environmentObject(SessionStore())
            .environmentObject(ViewRouter())

    }
}
