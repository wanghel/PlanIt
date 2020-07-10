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
    
    @ObservedObject var dayTaskVM = TaskViewModel(taskRepository: TaskRepository())
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    @State var showingDateSelector = false
    
    @Binding var showingDetail: Bool
    
    private var addNewTask = true
    
    init(showingDetail: Binding<Bool>) {
        self._showingDetail = showingDetail
        self.taskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()), taskRepository: TaskRepository())
    }
    
    init(showingDetail: Binding<Bool>, day: Date) {
        self._showingDetail = showingDetail
        self.taskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: day), taskRepository: TaskRepository())
    }
    
    init(showingDetail: Binding<Bool>, taskCellVM: TaskCellViewModel) {
        self._showingDetail = showingDetail
        self.taskCellVM = taskCellVM
        addNewTask = false
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        return dateFormatterPrint
    }
    
    var body: some View {
        ZStack {
            navy
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Add Task")
                        .opacity(0.9)
                        .font(.custom("GillSans", size: 35))
                    Spacer()
                    Button(action: {
                        if self.addNewTask {
                            self.dayTaskVM.addTask(task: self.taskCellVM.task)
                        }
                        
                        self.showingDetail.toggle()
                    }) {
                        Text("Done")
                    }
                }
                .padding()
                
                TextField("Enter title", text: $taskCellVM.task.title)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.8).cornerRadius(10))
                
                VStack {
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
                        HStack {
                            Spacer()
                            DatePicker("", selection: $taskCellVM.task.dayAssigned, displayedComponents: .date)
                                .labelsHidden()
                            Spacer()
                        }
                        
                    }
                }
                .background(Color.white.opacity(0.8).cornerRadius(10))
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(showingDetail: .constant(true))
            .environmentObject(ViewRouter())
    }
}
