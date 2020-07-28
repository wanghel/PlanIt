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
    
//    @State var image = Image(systemName: "person.crop.circle.fill")
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                darkerBackground
                    .edgesIgnoringSafeArea(.all)
                
                ProfileMainView()
                
                
                if self.viewRouter.showSignIn {
//                    AuthView(profileVM: self.$profileVM)
                    AuthView()
                }
            }
            .frame(width: screenWidth)
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
        print("on appear get user")
        session.listen()
    }
    
    // !!! DOESN'T WORK YET !!!
    func getFriendProfilePic(friend: UserViewModel) -> Image {
        friend.fetchProfilePic()
        
        if let image = friend.profilePic {
            print("succeed")
            return Image(uiImage: image)
        } else {
            print("failed")
            return Image(systemName: "person.crop.circle.fill")
        }
    }
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    Image(uiImage: session.profilePic ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.9)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 4).frame(width: 160, height: 160))
                    
                    
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
//                                    Image(systemName: "person.crop.circle.fill")
                                    //!!! DOESN"T WORK YET !!!
                                    self.getFriendProfilePic(friend: UserViewModel(profile: friend))
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
    
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    func setValue() -> Void {
        userName = session.profileVM?.profile.userName ?? ""
        name = session.profileVM?.profile.name ?? ""
        bio = session.profileVM?.profile.bio ?? ""
        image = session.profilePic
    }
    
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func getProfilePic() -> Image {
        if image == nil {
            return Image(systemName: "person.crop.circle.fill")
        } else {
            return Image(uiImage: image ?? UIImage())
        }
    }
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    HStack {
                        Button(action: {self.showImagePicker.toggle()}) {
                            getProfilePic()
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.9)
                                .frame(width: 160, height: 160)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 4).frame(width: 160, height: 160))
                        }
                    }
                    .padding()
                    
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
                    
                    Spacer()
                    
                }
                .padding()
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
                    
                    self.session.profilePic = self.image
                }
                self.goBack()
            }) {
                Text("Done")
                    .foregroundColor(.white)
        })
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.image = image
                }
        }
        
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
            .environmentObject(SessionStore())
            .environmentObject(ViewRouter())

    }
}
#endif
