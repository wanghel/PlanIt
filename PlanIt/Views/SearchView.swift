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
    
    @State var searchText = ""
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 0){
                    SearchBarView(searchText: $searchText)
                        
                    
                    ScrollView {
                        // IDK WHY DOING THIS MAKES THE DATA LOAD
                        Text("")
                            .frame(width: screenWidth, height: 0)
                        // FIGURE IT OUT FUTURE ME
                        
                        ForEach (dayTaskVM.taskCellViewModels.filter{$0.task.title.lowercased().contains(searchText.lowercased())}) { taskCellVM in
                            HStack {
                                Text(taskCellVM.task.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    
                                Spacer()
                            }
                            .background(Color.white.opacity(0.7))
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
            
            if self.searchText != "" {
                Button (action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle")
                }
            }
        }
        .padding()
        .background(
            Color.white.opacity(0.7)
            .cornerRadius(15))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
        .environmentObject(SessionStore())
//        SearchBarView()
    }
}
