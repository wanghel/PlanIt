//
//  EventView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct EventView: View {
    @ObservedObject var event: EventViewModel
    
    func getTime(time: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        return dateFormatterPrint.string(from: time)
    }
    
    func getDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatterPrint.string(from: event.event.beginTime)
    }
    
    var body: some View {
        VStack {
            Text(event.event.title)
                .font(.title)
                .bold()
            .padding()
            HStack {
                Text(getDate())
                Spacer()
            }
            .padding()
            HStack {
                Text("Begin")
                    .foregroundColor(.gray)
                Text(getTime(time: event.event.beginTime))
                Spacer()
            }
            .padding()
            HStack {
                Text("End")
                    .foregroundColor(.gray)
                Text(getTime(time: event.event.endTime))
                Spacer()
            }
            .padding()
            HStack {
                Text("Location")
                    .foregroundColor(.gray)
                Text(event.event.location)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .renderingMode(.original)
                }
            }
            .padding()
            Spacer()
            HStack {
                Text("Note")
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding()
            Text(event.event.notes)
                .padding()
                .frame(width: screenWidth, alignment: .leading)
            Spacer()
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: EventViewModel(event: testEvent))
    }
}
