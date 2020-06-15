//
//  DayView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct DayView: View {
    @Binding var isShowingDayView : Bool
    
    func printTime(hour: Int) -> String {
        return "\(hour%12 == 0 ? 12 : hour%12) \(hour/12 == 0 ? "AM" : "PM")"
    }
    
    @Binding var dayViewDate: Date
    
    @ObservedObject var dayTaskVM = DayTaskViewModel()
    
    @State var presentAddNewItem = false
    
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
    
    
    var body: some View {
        VStack (spacing:0){
            DayBarView(isShowingDayView: $isShowingDayView, dayViewDate: $dayViewDate)
                .background(Color.white)
            
            VStack(alignment: .leading) {
                List {
                    ForEach(dayTaskVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()))) { task in
                            if(task.title != "") {
                                self.dayTaskVM.addTask(task: task)
                            }
                            self.presentAddNewItem.toggle()
                        }
                    }
                    if !presentAddNewItem {
                        Button (action: {
                            self.presentAddNewItem.toggle()
                        }) {
                            Spacer()
                        }
                    }
                    
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.vertical)
        .offset(x: isShowingDayView ? 0 : -screenWidth)
        .animation(.none)
        
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = {_ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing)
            VStack {
                Spacer()
                TextField("", text: $taskCellVM.task.title, onCommit: {
                    self.onCommit(self.taskCellVM.task)
                })
                Divider()
            }
            
        }
    }
}



//small nav bar extended from main nav bar
struct DayBarView: View {
    @Binding var isShowingDayView : Bool
    @Binding var dayViewDate: Date
    
    func formatDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: dayViewDate)
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.dayViewDate.addTimeInterval(TimeInterval(-86400))
                    }){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                    Text(formatDate())
                        .font(.system(size: 20))
                        .opacity(0.7)
                        .padding(.horizontal)
                    Button(action: {
                        self.dayViewDate.addTimeInterval(TimeInterval(86400))
                    }){
                        Image(systemName: "chevron.right")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .opacity(0.7)
                    }
                    Spacer()
                }
                    
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowingDayView.toggle()
                    }){
                        HStack (spacing: 5) {
                            Image(systemName: "calendar")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                                .opacity(0.5)
                            Image(systemName: "chevron.right")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .opacity(0.5)
                        }
                    }
                }
                .frame(height: 40)
                .padding(.horizontal)
                .clipped()
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(isShowingDayView: .constant(true), dayViewDate: .constant(Date()))
    }
}

