//
//  LabelImage.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct LabelImage: View {
    var img: String
    var body: some View {
        Image(img)
        .resizable()
            .frame(width: 150)
    }
}

struct LabelImage_Previews: PreviewProvider {
    static var previews: some View {
        LabelImage(img: "planet1")
    }
}
