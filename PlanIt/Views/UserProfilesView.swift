//
//  UserProfilesView.swift
//  PlanIt
//
//  Created by Helen Wang on 7/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

//struct UserProfilesView: View {
//    @EnvironmentObject var session: SessionStore
//    @ObservedObject var userProfilesVM = UserProfilesViewModel()
////    @State var profile: UserProfile?
//
//    @State var friendProfile: UserProfile
//
//    var body: some View {
//        ZStack {
//            dnavy
//                .edgesIgnoringSafeArea(.all)
//
//            ScrollView {
//                VStack {
//
//                    HStack {
//                        Image(systemName: "person.crop.circle.fill").resizable()
//                            .frame(width: 150, height: 150)
//
//                        Spacer()
//
//                        VStack {
//                            HStack {
//                                Text(friendProfile.firstName).font(.title)
//                                Text(friendProfile.lastName).font(.title)
//                            }
//
//                            Text(friendProfile.userName)
//                                .font(.system(size: 15))
//
//                            Spacer()
//
//                            Button(action: {
//                                if (self.session.profile?.friends ?? []).contains(where: { friendID in
//                                    return friendID == self.friendProfile.id }) {
//                                    print("DOES CONTAIN")
//                                    self.session.profile?.friends.removeAll(where: {$0 == self.friendProfile.id})
//                                    self.session.updateProfile()
//
//                                } else {
//                                    print("DOES NOT CONTAIN")
//                                    self.session.profile?.friends.append(self.friendProfile.id)
//                                    self.session.updateProfile()
//
//                                }
//                                print(self.friendProfile.friends)
//                            }) {
//                                HStack {
//                                    if (self.session.profile?.friends ?? []).contains { friendID in
//                                        return friendID == self.friendProfile.id } {
//                                        Text("Friends")
//                                        Image(systemName: "checkmark")
//                                    } else {
//                                        Text("Add Friend")
//                                        Image(systemName: "plus")
//                                    }
//                                }
//                                .padding(15)
//                                .background(Color.blue.opacity(0.4))
//                                .cornerRadius(15)
//                            }
//                        }
//                        .padding([.horizontal, .top])
//
//                    }
//                    .padding()
//
//                    NavigationLink(destination:
//                        Text("Friends")
//                        .navigationBarTitle("\(friendProfile.userName)'s friends", displayMode: .inline)) {
////                            .navigationBarTitle("\(friendProfileVM.profile.userName)'s friends", displayMode: .inline)) {
//                                HStack {
//                                    Text("Friends")
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                }
//                                .padding()
//                                .background(navy)
//                    }
//
//                    NavigationLink(destination:
//                        Text("Calendar")
//                            .navigationBarTitle("\(friendProfile.userName)'s calendar", displayMode: .inline)) {
//                                HStack {
//                                    Text("Calendar")
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                }
//
//                                .padding()
//                                .background(navy)
//                    }
//
//
//                    Spacer()
//                }
//                .foregroundColor(.white)
//                .animation(.none)
//            }
//        }
//    }
//}

struct UserProfilesView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var userProfilesVM = UserProfilesViewModel()
//    @State var profile: UserProfile?
    
//    @ObservedObject var profileVM: UserViewModel
    @ObservedObject var friendProfile: UserViewModel
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        ZStack {
            dnavy
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                VStack {
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text(friendProfile.profile.firstName ?? "").font(.title)
                                Text(friendProfile.profile.lastName ?? "").font(.title)
                            }
                            
                            Text(friendProfile.profile.userName ?? "")
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Button(action: {
                                if (self.session.profileVM?.profile.friends ?? []).contains(where: { friendID in
                                    return friendID == self.friendProfile.profile.id }) {
                                    print("DOES CONTAIN")
                                    self.session.profileVM?.profile.friends?.removeAll(where: {$0 == self.friendProfile.id})
                                    //                                    self.session.updateProfile()
                                    
                                } else {
                                    print("DOES NOT CONTAIN")
                                    
                                    self.session.profileVM?.profile.friends?.append(self.friendProfile.id)
                                    //                                    self.session.updateProfile()
                                    
                                }
                                print(self.friendProfile.profile.friends)
                            }) {
                                HStack {
                                    if (self.session.profileVM?.profile.friends ?? []).contains { friendID in
                                        return friendID == self.friendProfile.profile.id } {
                                        Text("Friends")
                                        Image(systemName: "checkmark")
                                    } else {
                                        Text("Add Friend")
                                        Image(systemName: "plus")
                                    }
                                }
                                .padding(15)
                                .background(Color.blue.opacity(0.4))
                                .cornerRadius(15)
                                
                                
                            }
                        }
                        .padding([.horizontal, .top])
                        
                    }
                    .padding()
                    
                    NavigationLink(destination:
                        Text("Friends")
                            .navigationBarTitle("\(friendProfile.profile.userName ?? "")'s friends", displayMode: .inline)) {
                                //                            .navigationBarTitle("\(friendProfileVM.profile.userName)'s friends", displayMode: .inline))
                                
                                HStack {
                                    Text("Friends")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .background(navy)
                    }
                    
                    NavigationLink(destination:
                        Text("Calendar")
                            .navigationBarTitle("\(friendProfile.profile.userName ?? "")'s calendar", displayMode: .inline)) {
                                HStack {
                                    Text("Calendar")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                    
                                .padding()
                                .background(navy)
                    }
                    
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .animation(.none)
            }
            
        }
//        .onAppear(perform: getUser)
    }
}


//struct FriendsView: View {
//    @Binding var profile: UserProfile?
//    @ObservedObject var userProfilesVM = UserProfilesViewModel()
//
//    var body: some View {
//        VStack (alignment: .leading) {
//            ForEach(profile?.friends ?? [], id: \.self) { friend in
//                Button(action: {}) {
//                    HStack {
//                        Image(systemName: "person.crop.circle.fill")
//                        Text(friend.userName)
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.gray)
//                    }
//                    .padding()
//                }
//            }
//            Text("Friends")
//        }
//    }
//}

struct UserProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        UserProfilesView(friendProfile: testUser3)
    }
}
