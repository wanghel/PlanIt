//
//  SettingsView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/30/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                dnavy
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
                                .background(navy)
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
                                .background(navy)
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
                                .background(navy)
                                .cornerRadius(10)
                    }
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
