//
//  ProfileView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/11/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewControl: ViewControl
    @EnvironmentObject var session: SessionStore
    
    @State var person: User = testUser1
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            
            ZStack {
                if (session.session != nil) {
                    
                    //Profile view main
                    GeometryReader {_ in
                        ScrollView {
                            ProfileMainView()
                        }
                        .frame(width: screenWidth)
                        .background(Color.white)
                        .padding(.top, 60)
                    }
                    
                } else {
                    //NEED TO CHANGE
                    
                    SignInView()
                    if(viewControl.showSignUp) {
                        SignUpView()
                    }
                }
                
                // Profile view bar
                
                ProfileBarView(person: $person).edgesIgnoringSafeArea(.vertical)
                
                
            }
            .offset(y: viewControl.viewProfile ? 0 : screenHeight)
            .animation(.default)
        }
        .onAppear(perform: getUser)
        
    }
}

struct ProfileMainView: View {
    //@Binding var person: User
    var person = testUser1
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill").resizable().frame(width: 150, height: 150)
            HStack {
                Text(person.firstName).font(.title)
                Text(person.lastName).font(.title)
            }
//                        Spacer()
//                        Text(person.bio)
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
                ForEach(person.friends, id: \.self) { friend in
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text(friend)
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
    }
}

struct ProfileBarView: View {
    @EnvironmentObject var viewControl: ViewControl
    @EnvironmentObject var session: SessionStore
    
    @Binding var person: User
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.viewControl.viewProfile = false
                    print(screenHeight)
                }){
                    Image(systemName: "chevron.down")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .opacity(0.7)
                }
                Text(person.userName)
                    .font(.system(size: 25))
                    .opacity(0.7)
                    .padding(.horizontal)
                Spacer()
                Button(action: {}){
                    Image(systemName: "pencil")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .padding()
                }
                Button(action: {
                    self.session.signOut()
                    self.viewControl.showSignIn.toggle()
                    self.viewControl.dayTaskVM.taskRepository.reloadData()
                }){
                    Image(systemName: "gear")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .opacity(0.7)
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


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView().environmentObject(SessionStore())
        //ContentView()
    }
}
