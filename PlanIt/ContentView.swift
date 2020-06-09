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
   @State var viewProfile = false
    
    var body: some View {
        ZStack {
            MainView(viewProfile: $viewProfile)
            ProfileView(viewProfile: $viewProfile)
        }
        
    }
}

struct MainView: View {
    @State var selected = 0
    @Binding var viewProfile : Bool
    
    func chooseMainView() -> AnyView {
        switch selected {
        case 1:
            return AnyView(InfiniteCalendarView())
        case 2:
             return AnyView(Text("View 2"))
        default:
            return AnyView(Text("Home"))
        }
        
    }
    
    var body: some View {
        ZStack {
            
            GeometryReader {_ in
                VStack {
                    self.chooseMainView()
                }
            }
            
            VStack {
                TopBar (viewProfile: $viewProfile)
                Spacer()
                BottonBar(selected: $selected)
            }.edgesIgnoringSafeArea(.vertical)
        
        }
    }
    
}

struct TopBar: View {
    @Binding var viewProfile : Bool
    
    var body: some View {
        
            HStack {
                Button(action: {
                    self.viewProfile = true
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
            }.frame(height: screenHeight * 0.06, alignment: .bottom)
                .padding([.leading, .bottom, .trailing])
                .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
                .background(Color.white)
                .clipped()
                .shadow(radius: 2)
        
    }
}

struct ProfileView: View {
    @Binding var viewProfile : Bool
    var userName : String = "hwang"
    
    var body: some View {
        ZStack {
            //Profile view main
            GeometryReader {_ in
                VStack {
                Spacer()
                Text("Profile")
                Spacer()
            }.frame(width: screenWidth)
                .background(Color.white)
            }
            
            // Profile view bar
            VStack {
                HStack {
                    Button(action: {
                        self.viewProfile = false
                    }){
                        Image(systemName: "chevron.down")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                    Text(userName)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
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
                    Button(action: {}){
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                }.frame(height: screenHeight * 0.06, alignment: .bottom)
                    .padding([.leading, .bottom, .trailing])
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
                    .background(Color.white)
                    .clipped()
                    .shadow(radius: 2)
                
                Spacer()
            }
            
        }.edgesIgnoringSafeArea(.vertical)
        .offset(y: viewProfile ? 0 : screenHeight)
        .animation(.default)
    }
}

// not sure I need this (changes something in scene delegate)
class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
}

struct BottonBar: View {
    @Binding var selected : Int
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.selected = 0
                }){
                    Image(systemName: self.selected == 0 ? "house.fill" : "house")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    self.selected = 1
                }){
                    Image(systemName: self.selected == 1 ? "calendar.circle.fill" : "calendar.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    self.selected = 2
                }){
                    Image(systemName: self.selected == 2 ? "person.2.fill" : "person.2")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
            }
        }.padding()
            .padding(.horizontal)
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)!)
            .background(Color.white)
            .clipped()
            .shadow(radius: 2)
    }
}


struct ContentView_Prviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
