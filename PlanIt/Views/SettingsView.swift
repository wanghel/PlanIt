//
//  SettingsView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/30/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView {
            ZStack {
                darkerBackground
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    NavigationLink(destination:
                        Text("Second View")
                            .navigationBarTitle("First Link", displayMode: .inline)) {
                                HStack {
                                    Text("First Link")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .background(darkBackground)
                                .cornerRadius(10)
                    }
                    
                    
                    NavigationLink(destination:
                        Text("Help")
                            .navigationBarTitle("Help", displayMode: .inline)) {
                                HStack {
                                    Text("Help")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                    
                                .padding()
                                .background(darkBackground)
                                .cornerRadius(10)
                                
                    }
                    
                    NavigationLink(destination:
                        Text("Send feedback")
                            .navigationBarTitle("Send feedback", displayMode: .inline)) {
                                HStack {
                                    Text("Send feedback")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding()
                                .background(darkBackground)
                                .cornerRadius(10)
                    }
                    
                    Button(action: {
                        self.session.signOut()
//                        self.profileVM = UserViewModel(profile: User(id: ""))
                        self.viewRouter.showSignIn = true
                    }){
                        HStack {
                            Text("Log out")
                            Spacer()
                        }
                        .padding()
                        .background(darkBackground)
                        .cornerRadius(10)
                    }
                    .padding(.vertical)
                    
                }
                .padding()
                
            }
            .foregroundColor(.white)
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
