//
//  UserProfilesView.swift
//  PlanIt
//
//  Created by Helen Wang on 7/2/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct UserProfilesView: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject var userProfilesVM: UserProfilesViewModel //= UserProfilesViewModel(userProfileRepository: UserProfileRepository())
    @ObservedObject var friendProfile: UserViewModel
    
    func isFriend(friendId: String) -> Bool {
        for friend in session.profileVM?.profile.friends ?? [] {
            if friendId == friend {
                return true
            }
        }
        return false
    }
    
    func setProfilePic() {
        userProfilesVM.userProfileRepository.fetchImage(friendProfile.id) { (image, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.friendProfile.profilePic = image
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                VStack {
                    
                    HStack {
                        ProfilePicView(image: self.friendProfile.profilePic, size: 160)
                            .padding()
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text(friendProfile.profile.name ?? "").font(.title)
                            }
                            
                            Text(friendProfile.profile.userName ?? "")
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Button(action: {
                                if (self.session.profileVM?.profile.friends ?? []).contains(where: { friendID in
                                    return friendID == self.friendProfile.profile.id }) {
                                    print("DOES CONTAIN")
                                    self.session.profileVM?.profile.friends?.removeAll(where: {$0 == self.friendProfile.id})
                                    
                                } else {
                                    print("DOES NOT CONTAIN")
                                    self.session.profileVM?.profile.friends?.append(self.friendProfile.id)
                                    
                                }
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
                    
                    HStack {
                        Text(friendProfile.profile.bio ?? "")
                            .font(.body)
                            .padding()
                        Spacer()
                    }
                    
                    
                    if friendProfile.profile.isPrivate ?? false && !self.isFriend(friendId: friendProfile.profile.id) {
                        HStack {
                            Image(systemName: "lock.slash.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            VStack {
                                Text("This user is private.")
                                    .bold()
                                Text("Friend this user to see their to-do list.")
                            }
                            .padding(.leading)
                        }
                        .padding()
                    }
                    
//                    NavigationLink(destination:
//                        Text("Friends")
//                            .navigationBarTitle("\(friendProfile.profile.userName ?? "")'s friends", displayMode: .inline)) {
//                                HStack {
//                                    Text("Friends")
//                                    Spacer()
//                                    Image(systemName: (!(friendProfile.profile.isPrivate ?? false) || self.isFriend(friendId: friendProfile.profile.id)) ? "chevron.right" : "lock.slash.fill")
//                                }
//                                .padding()
//                                .background(navy)
//                    }
                    
                    NavigationLink(destination:
                        FriendCalendarView(friendProfile: friendProfile)
                            .navigationBarTitle("\(friendProfile.profile.userName ?? "")", displayMode: .inline)) {
                                HStack {
                                    Text("Calendar")
                                    Spacer()
                                    Image(systemName: (!(friendProfile.profile.isPrivate ?? false) || self.isFriend(friendId: friendProfile.profile.id)) ? "chevron.right" : "lock.slash.fill")
                                }
                                    
                                .padding()
                                .background(darkBackground)
                    }.disabled(friendProfile.profile.isPrivate ?? false && !self.isFriend(friendId: friendProfile.profile.id))
                    
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .animation(.none)
            }
            
        }
        .foregroundColor(.white)
//        .onAppear(perform: setProfilePic)
    }
}



#if DEBUG
struct UserProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        UserProfilesView(friendProfile: UserViewModel(profile: testUser3))
    }
}
#endif
