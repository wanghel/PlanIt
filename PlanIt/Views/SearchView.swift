//
//  SearchView.swift
//  PlanIt
//
//  Created by Helen Wang on 7/1/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var dayTaskVM = TaskViewModel()
    @ObservedObject var userProfilesVM = UserProfilesViewModel()
    
    @State var searchText = ""
    @State var searchUsers = true
    
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 0){
                    
                    VStack {
                        SearchBarView(searchText: $searchText)
                            .padding(.bottom)
                        
                        if searchText != "" {
                            HStack {
                                Button (action : {self.searchUsers = true}) {
                                    Spacer()
                                    Image(systemName: "person.2")
                                        .foregroundColor(searchUsers ? .white : .gray)
                                    Spacer()
                                }
                                Text("|")
                                Button (action : {self.searchUsers = false}) {
                                    Spacer()
                                    Image(systemName: "calendar")
                                        .foregroundColor(searchUsers ? .gray : .white)
                                    Spacer()
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding([.horizontal])
                    .background(ddnavy)
                    
                    ScrollView {
                        // IDK WHY DOING THIS MAKES THE DATA LOAD
                        Text("")
                            .frame(width: screenWidth, height: 0)
                        // FIGURE IT OUT FUTURE ME
                        
                        VStack (spacing: 0){
                            
                            if searchUsers {
                                ForEach (userProfilesVM.userVM.filter{$0.profile.userName.lowercased().contains(searchText.lowercased()) && $0.profile.id != session.profile?.id}) { userVM in
                                    
                                    NavigationLink (destination:
                                        UserProfilesView(friendProfile: userVM.profile)
//                                        UserProfilesView(friendProfileVM: userVM)
                                        .foregroundColor(.black)) {
                                            HStack {
                                                Text(userVM.profile.userName)
                                                    .padding()
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                    }
                                    .padding(.horizontal)
                                    
                                }
                            } else {
                                ForEach (dayTaskVM.taskCellViewModels.filter{$0.task.title.lowercased().contains(searchText.lowercased())}) { taskCellVM in
                                    
                                    NavigationLink (destination: Text(taskCellVM.task.title)
                                        .foregroundColor(.black)) {
                                            HStack {
                                                Text(taskCellVM.task.title)
                                                    .padding()
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                    }
                                    .padding(.horizontal)
                                    
                                }
                            }
                            
                        }
                        .background(Color.white.opacity(0.7).cornerRadius(10))
                    }
                    
                    Spacer()
                }
                .foregroundColor(.white)
//                .padding()
                
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
            
            if self.searchText != "" {
                Button (action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle")
                }
            }
        }
        .padding(10)
        .background(
            Color.white.opacity(0.7)
            .cornerRadius(10))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
        .environmentObject(SessionStore())
//        SearchBarView()
    }
}
