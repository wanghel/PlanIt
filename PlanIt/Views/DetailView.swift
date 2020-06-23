//
//  DetailView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/22/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var session: SessionStore
    @ObservedObject var dayTaskVM = DayTaskViewModel()
    
//    @State var title: String = ""
//    @State var dayAssigned: Date = Date()
    @ObservedObject var taskCellVM: TaskCellViewModel = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()))
    
    @State var showingDateSelector = false
    
    @Binding var showingDetail: Bool
    
    var addNewTask = true
    
    init(showingDetail: Binding<Bool>) {
        self._showingDetail = showingDetail
        self.taskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: self.viewRouter.dateShown))
    }
    
    init(showingDetail: Binding<Bool>, taskCellVM: TaskCellViewModel) {
        self._showingDetail = showingDetail
//        self.title = title
//        self.dayAssigned = dayAssigned
        self.taskCellVM = taskCellVM
        addNewTask = false
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        return dateFormatterPrint
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Todo")
                    .opacity(0.7)
                    .font(.title)
                Spacer()
                Button(action: {
                    //self.dayTaskVM.addTask(task: Task(title: self.title, completed: false, dayAssigned: self.dayAssigned))
                    if self.addNewTask {
                        self.dayTaskVM.addTask(task: self.taskCellVM.task)
                    }
//                    else {
//                        self.dayTaskVM.updateTask(task: self.taskCellVM.task)
//                    }
                    self.showingDetail.toggle()
                }) {
                    Text("Done")
                }
            }
            .padding()
            
            TextField("Enter title", text: $taskCellVM.task.title)
                .padding()
            
            Button (action: {
                self.showingDateSelector.toggle()
            }) {
                HStack {
                    Text("Date Assigned")
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    Text("\(taskCellVM.task.dayAssigned, formatter: dateFormatter)")
                    .foregroundColor(.gray)
                    .padding()
                }
            }
            
            if showingDateSelector {
                DatePicker("", selection: $taskCellVM.task.dayAssigned, in: Date()..., displayedComponents: .date)
                    .labelsHidden()
                
            }
            
            Spacer()
        }

        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(showingDetail: .constant(true))
    }
}
