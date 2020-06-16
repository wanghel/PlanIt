//
//  ContentView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


struct ContentView: View {
    @EnvironmentObject var viewControl: ViewControl
    
    
    func chooseMainView() -> AnyView {
        switch viewControl.selected {
        case 1:
            return AnyView(HomeView())
        case 2:
            return AnyView(Text("Reminders"))
        default:
            return AnyView(CalendarView())
        }
        
    }
    
    var body: some View {
        ZStack {
            GeometryReader {_ in
                self.chooseMainView()
                    .padding(.top, 60)
                    .padding(.bottom, 50)
            }
            
            
            VStack {
                TopBar ()
                Spacer()
                BottonBar()
            }.edgesIgnoringSafeArea(.vertical)
            
            ProfileView()
        }
    }
    
}

struct TopBar: View {
    @EnvironmentObject var viewControl: ViewControl
    
    var body: some View {
        
        HStack {
            Button(action: {
                self.viewControl.viewProfile = true
            }){
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            Text("PlanIt")
                .font(.system(size: 35))
                .fontWeight(.semibold)
                .opacity(0.7)
                .padding(.horizontal)
            Spacer()
            Button(action: {}){
                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
        }.frame(height: 60)
            .padding(.horizontal)
            .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.white)
            .clipped()
        
    }
}

struct BottonBar: View {
    @EnvironmentObject var viewControl: ViewControl
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.viewControl.isShowingDayView = false
                    self.viewControl.selected = 0
                }){
                    Image(systemName: self.viewControl.selected == 0 ? "calendar.circle.fill" : "calendar.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    self.viewControl.isShowingDayView = true
                    self.viewControl.selected = 1
                }){
                    Image(systemName: self.viewControl.selected == 1 ? "house.fill" : "house")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    self.viewControl.isShowingDayView = false
                    self.viewControl.selected = 2
                }){
                    Image(systemName: self.viewControl.selected == 2 ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
            }
        }.padding()
            .padding(.horizontal)
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
            .background(Color.white)
            .clipped()
    }
}

// not sure I need this (changes something in scene delegate)
//class Host: UIHostingController<ContentView> {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return.lightContent
//    }
//}


struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
