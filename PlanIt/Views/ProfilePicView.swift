//
//  ProfilePicView.swift
//  PlanIt
//
//  Created by Helen Wang on 7/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct ProfilePicView: View {
    var image: Image
    var size: CGFloat
    
    init(image: UIImage?, size: CGFloat) {
        if image == nil {
            self.image = Image(systemName: "person.crop.circle.fill")
        } else {
            self.image = Image(uiImage: image ?? UIImage())
                .renderingMode(.original)
        }
        
        self.size = size
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.gray)
            .opacity(0.9)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: size/40).frame(width: size, height: size))
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(image: nil, size: 160)
    }
}
