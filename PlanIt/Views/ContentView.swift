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
let navy = Color(red: 0.25, green: 0.25, blue: 0.30)
let dnavy = Color(red: 0.15, green: 0.15, blue: 0.20)

/*func getColor(eventVM: EventViewModel) -> Color {
   switch eventVM.event.color {
   case "pink":
       return pink
   case "red":
       return red
   case "orange":
       return orange
   case "yellow":
       return yellow
   case "green":
       return green
   case "blue":
       return blue
   case "purple":
       return purple
   default:
       return Color.black
   }
}*/

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    
    @State private var currentTab = 1
    
    init () {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.05, alpha: 1)
        
        UINavigationBar.appearance().barTintColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.05, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Helvetica Neue", size: 30)!, .foregroundColor: UIColor.white]
        
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $currentTab) {
                HomeView()
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
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 25))
                        Text(currentTab == 3 ? "_____" : "")
                }.tag(3)
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                        Text(currentTab == 4 ? "_____" : "")
                }.tag(4)
            }
            .accentColor(.white)
            
            
            ProfileView()
            
            
        }
    }
    
}

//struct ContentView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    @EnvironmentObject var session: SessionStore
//    @State var showingDetail = false
//
//    func chooseMainView() -> AnyView {
//        switch viewRouter.selected {
//        case 1:
//            return AnyView(HomeView())
//        case 2:
//            return AnyView(Text("Community"))
//        default:
//            return AnyView(CalendarView())
//        }
//
//    }
//
//    var body: some View {
//        ZStack {
//            GeometryReader {_ in
//                self.chooseMainView()
//                    .padding(.top, 60)
//                    .padding(.bottom, 50)
//            }
//
//
//            VStack {
//                TopBar (showingDetail: $showingDetail)
//                Spacer()
//                BottonBar()
//            }.edgesIgnoringSafeArea(.vertical)
//
//            ProfileView()
//        }
//    }
//
//}
//
//struct TopBar: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    @Binding var showingDetail: Bool
//
//    var body: some View {
//
//        HStack {
//            Button(action: {
//                self.viewRouter.viewProfile = true
//            }){
//                Image(systemName: "person.crop.circle.fill")
//                    .font(.system(size: 30))
//                    .foregroundColor(.black)
//                    .opacity(0.7)
//            }
//            Text("PlanIt")
//                .font(.system(size: 35))
//                .fontWeight(.semibold)
//                .opacity(0.7)
//                .padding(.horizontal)
//            Spacer()
//            Button(action: {
//                self.showingDetail.toggle()
//            }){
//                Image(systemName: "plus")
//                    .font(.system(size: 30))
//                    .foregroundColor(.black)
//                    .opacity(0.7)
//            }.sheet(isPresented: $showingDetail) {
//                DetailView(showingDetail: self.$showingDetail)
//            }
//
//        }.frame(height: 60)
//            .padding(.horizontal)
//            .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
//            .background(Color.white)
//            .clipped()
//
//    }
//}
//
//struct BottonBar: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//
//    var body: some View {
//        VStack {
//            HStack {
//                Button(action: {
//                    self.viewRouter.isShowingDayView = false
//                    self.viewRouter.selected = 0
//                }){
//                    Image(systemName: self.viewRouter.selected == 0 ? "calendar.circle.fill" : "calendar.circle")
//                        .font(.system(size: 25))
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                Button(action: {
//                    self.viewRouter.isShowingDayView = true
//                    self.viewRouter.dateShown = Date()
//                    self.viewRouter.selected = 1
//                }){
//                    Image(systemName: self.viewRouter.selected == 1 ? "house.fill" : "house")
//                        .font(.system(size: 25))
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                Button(action: {
//                    self.viewRouter.isShowingDayView = false
//                    self.viewRouter.selected = 2
//                }){
//                    Image(systemName: self.viewRouter.selected == 2 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
//                        .font(.system(size: 25))
//                        .foregroundColor(.gray)
//                }
//            }
//        }.padding()
//            .padding(.horizontal)
//            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
//            .background(Color.white)
//            .clipped()
//    }
//}

// not sure I need this (changes something in scene delegate)
//class Host: UIHostingController<ContentView> {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return.lightContent
//    }
//}


struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(SessionStore())
        .environmentObject(ViewRouter())
    }
}
