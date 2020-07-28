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

let pink = Color(red: 1.0, green: 0.8, blue: 0.8)
let red = Color(red: 1.0, green: 0.6, blue: 0.6)
let orange = Color(red: 1.0, green: 0.7, blue: 0.6)
let yellow = Color(red: 1.0, green: 0.9, blue: 0.5)
let green = Color(red: 0.8, green: 0.97, blue: 0.6)
let blue = Color(red: 0.7, green: 0.95, blue: 0.9)
let purple = Color(red: 0.9, green: 0.7, blue: 0.9)
let darkBackground = Color(red: 0.3, green: 0.3, blue: 0.30)
let darkerBackground = Color(red: 0.15, green: 0.15, blue: 0.15)
let darkestBackground = Color(red: 0.12, green: 0.12, blue: 0.12)


struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var currentTab = 1
    @State var showSplash: Bool = true
    
    init () {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor.init(displayP3Red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        
        UINavigationBar.appearance().barTintColor = UIColor.init(displayP3Red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "andromeda", size: 27)!, .foregroundColor: UIColor.white]
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            darkerBackground
            .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $currentTab) {
                    HomeView()
                        .onAppear(perform: {self.viewRouter.dateShown = Date()})
                .tabItem {
                    Image(systemName: currentTab == 1 ? "house.fill" : "house")
                        .font(.system(size: 23))
                    Text(currentTab == 1 ? "_____" : "")
                }.tag(1)
                
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar")
                            .font(.system(size: 25))
                        Text(currentTab == 2 ? "_____" : "")
                }.tag(2)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 25))
                        Text(currentTab == 3 ? "_____" : "")
                }.tag(3)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                        Text(currentTab == 4 ? "_____" : "")
                }.tag(4)
            }
            .accentColor(.white)
            .environmentObject(session)
                
            ProfileView()
            
            if showSplash {
                SplashView(showSplash: self.$showSplash)
                .zIndex(1)
            }
            
        }
        .foregroundColor(.white)
        
    }
    
}

#if DEBUG
struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(SessionStore())
        .environmentObject(ViewRouter())
        .environment(\.colorScheme, .dark)
    }
}
#endif
