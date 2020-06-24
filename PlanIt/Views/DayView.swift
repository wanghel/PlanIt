//
//  DayView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI
import Firebase

struct DayView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var dayTaskVM = DayTaskViewModel()
    
    @State var presentAddNewItem = false
    @State var showingDetail = false
    @State var detailedTaskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()))
    
    func printTime(hour: Int) -> String {
        return "\(hour%12 == 0 ? 12 : hour%12) \(hour/12 == 0 ? "AM" : "PM")"
    }
    
    var body: some View {
        VStack (spacing:0) {
            DayBarView()
            
            List {
                ForEach(dayTaskVM.taskCellViewModels) { taskCellVM in
                    if self.viewRouter.dateShown.isSameDay(taskCellVM.task.dayAssigned) {
                        TaskCell(taskCellVM: taskCellVM, showingDetail: self.$showingDetail, detailedTaskCellVM: self.$detailedTaskCellVM)
                            .onDisappear(perform: {
                                if taskCellVM.task.completed {
                                    self.dayTaskVM.deleteTask(task: taskCellVM.task)
                                }})
                    }
                }
                if presentAddNewItem {
                    TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: self.viewRouter.dateShown)), showingDetail: $showingDetail, detailedTaskCellVM: $detailedTaskCellVM) { task in
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
        .edgesIgnoringSafeArea(.vertical)
        .offset(x: viewRouter.isShowingDayView ? 0 : -screenWidth)
        .sheet(isPresented: self.$showingDetail) {
            DetailView(showingDetail: self.$showingDetail, taskCellVM: self.detailedTaskCellVM)
        }
        
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    @Binding var showingDetail: Bool
    @Binding var detailedTaskCellVM: TaskCellViewModel
    //@State var showingInfo = false
    var onCommit: (Task) -> (Void) = {_ in }
    
    var body: some View {
        
        HStack {
            Image(systemName: self.taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
            }
            
            VStack {
                Spacer()
                HStack {
                    TextField("", text: self.$taskCellVM.task.title, onCommit: {
                        self.onCommit(self.taskCellVM.task)
                        })
                    
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .opacity(0.3)
                        .onTapGesture {
                            self.showingDetail.toggle()
                            self.detailedTaskCellVM = self.taskCellVM
                            print("tapped info of \(self.taskCellVM.task.title)")
                    }
                    
                }
                Divider()
            }
            
        }
        
    }
}



//small nav bar extended from main nav bar
struct DayBarView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    func formatDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        return dateFormatterPrint.string(from: self.viewRouter.dateShown)
    }
    
    var body: some View {
        VStack {
            ZStack {
                
                HStack {
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .onTapGesture {
                            self.viewRouter.dateShown.addTimeInterval(TimeInterval(-86400))
                    }
                    
                    Text(formatDate())
                        .font(.system(size: 20))
                        .opacity(0.7)
                        .padding(.horizontal)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .onTapGesture {
                            self.viewRouter.dateShown.addTimeInterval(TimeInterval(86400))
                    }
                    
                    Spacer()
                }
                
                if self.viewRouter.selected == 0 {
                    HStack {
                        Spacer()
                        
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
                        .onTapGesture {
                            self.viewRouter.isShowingDayView.toggle()
                        }
                        
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    .clipped()
                }
            }
        }
        .background(Color.white)
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}

