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
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    ProfileMainView(profile: self.$profile)
                    
                }
                .frame(width: screenWidth)
                .padding(.top, 60)
                .navigationBarTitle("\(profile?.userName ?? "")", displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.viewRouter.viewProfile = false
                    }){
                        Image(systemName: "chevron.down")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .padding(.bottom)
                    }
                    ,
                    trailing:
                    HStack {
                        if !self.viewRouter.showSignIn {
                            Button(action: {
                                
                            }){
                                Image(systemName: "pencil")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                    .opacity(0.7)
                                    .padding([.bottom, .trailing])
                            }
                            
                            
                            Button(action: {
                                self.session.signOut()
                                self.profile = UserProfile(id: "", userName: "", firstName: "", lastName: "", friends: [])
                                self.viewRouter.showSignIn.toggle()
                            }){
                                Text("sign out")
                                    .font(.system(size: 15))
                                    .padding(.bottom)
//                                Image(systemName: "gear")
//                                    .font(.system(size: 25))
//                                    .foregroundColor(.white)
//                                    .opacity(0.7)
//                                    .padding(.bottom)
                            }
                        }
                })
                    .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
                    .frame(height: screenHeight)
                    .edgesIgnoringSafeArea(.all)
                
                if self.viewRouter.showSignIn {
                    AuthView(profile: self.$profile)
                        .frame(height: screenHeight)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .offset(y: viewRouter.viewProfile ? 0 : screenHeight)
        .animation(.easeOut)
        .onAppear(perform: getUser)
        
    }
    
}

struct ProfileMainView: View {
    @Binding var profile: UserProfile?
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            dnavy
            .edgesIgnoringSafeArea(.bottom)
        VStack {
            
            Image(systemName: "person.crop.circle.fill").resizable()
                .frame(width: 150, height: 150)
            
            HStack {
                Text(profile?.firstName ?? "").font(.title)
                Text(profile?.lastName ?? "").font(.title)
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
                ForEach(profile?.friends ?? [], id: \.self) { friend in
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text(friend.userName)
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
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView(profile: .constant(testUser1))
            .environmentObject(SessionStore())
            .environmentObject(ViewRouter())
    }
}
