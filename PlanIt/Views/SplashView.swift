//
//  SplashView.swift
//  PlanIt
//
//  Created by Helen Wang on 7/28/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            darkerBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer ()
                Text("PlanIt")
                    .font(Font.custom("andromeda", size: 40))
                Spacer ()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                    withAnimation {
                        self.showSplash = false
                    }
                }
        }
        .transition(.opacity)
        .animation(.easeInOut)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(showSplash: .constant(true))
    }
}
