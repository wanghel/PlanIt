//
//  HomeView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/13/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                darkerBackground
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 0) {
                    Text("~TODAY~")
                    .tracking(10)
                        .padding([.horizontal, .top])
                        .foregroundColor(.white)
                        .font(.custom("GillSans", size: 25))
                        .opacity(0.9)
                    
                    ScrollView {
                        // FORCES SCROLLVIEW TO SHOW IN CASE ARRAY IS EMPTY
                        Text("")
                            .frame(width: screenWidth, height: 0)
                        // FORCES SCROLLVIEW TO SHOW IN CASE ARRAY IS EMPTY
                        
                        
                        VStack {
                            TaskView(date: viewRouter.dateShown)
                        }
                        .padding(.top)
                        
                    }
                    
                }
                
            }
            .navigationBarTitle("PLANIT", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.viewRouter.viewProfile = true
                }){
//                    Image(systemName: "person.crop.circle.fill")
//                        .font(.system(size: 25))
//                        .foregroundColor(.white)
//                        .opacity(0.9)
//                        .padding([.bottom, .horizontal])
                    
                    Image(uiImage: session.profilePic ?? UIImage())
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.9)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1).frame(width: 32, height: 32))
                    .padding()

                }, trailing:
                Button(action: {
                    self.showingDetail.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .opacity(0.9)
                        .padding()
            })
        }
        .sheet(isPresented: $showingDetail) {
            DetailView(showingDetail: self.$showingDetail)
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        .environmentObject(SessionStore())
        .environmentObject(ViewRouter())
    }
}
#endif
