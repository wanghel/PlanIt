//
//  TaskView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/27/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var taskVM: TaskViewModel
    
    @State var showingDetail = false
    @State var detailTaskCellVM = TaskCellViewModel(task: Task(title: "", description: "", priority: TaskPriority.none, completed: false, dayAssigned: Date()), taskRepository: TaskRepository())
    
    
    init() {
        taskVM = TaskViewModel(taskRepository: TaskRepository())
    }
    
    init(date: Date) {
        taskVM = TaskViewModel(taskRepository: TaskRepository(date: date))
    }
    
    var body: some View {
        VStack {
            // IDK WHY DOING THIS MAKES THE DATA LOAD
            Text("")
                .frame(width: screenWidth, height: 0)
            // FIGURE IT OUT FUTURE ME
            
            ForEach (taskVM.taskCellViewModels) { taskCellVM in
//                if self.viewRouter.dateShown.isSameDay(taskCellVM.task.dayAssigned) {
                    TaskCell(dayTaskVM: self.taskVM, taskCellVM: taskCellVM, showingDetail: self.$showingDetail, detailTaskCellVM: self.$detailTaskCellVM)
                        .padding([.horizontal,.bottom])
                        .onDisappear(perform: {
                            if taskCellVM.task.completed {
                                self.taskVM.deleteTask(task: taskCellVM.task)
                            }})
//                }
            }
        }
        .sheet(isPresented: self.$showingDetail) {
            DetailView(showingDetail: self.$showingDetail, taskCellVM: self.detailTaskCellVM)
        }
    }
}


struct TaskCell: View  {
    @ObservedObject var dayTaskVM: TaskViewModel
    @ObservedObject var taskCellVM: TaskCellViewModel
    @Binding var showingDetail: Bool
    @Binding var detailTaskCellVM: TaskCellViewModel
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var showInfo = false
    
    func getPriorityColor(priority: TaskPriority) -> Color {
        switch priority {
        case .none:
            return .black
        case .low:
            return green
        case .medium:
            return yellow
        case .high:
            return red
        }
    }
    
    func getPriorityIndicator(priority: TaskPriority) -> String {
        switch priority {
        case .none:
            return ""
        case .low:
            return "!"
        case .medium:
            return "!!"
        case .high:
            return "!!!"
        }
    }
    
    var body: some View {
        ZStack {
            
            HStack {
                Image(systemName: self.taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding()
                    .onTapGesture {
                        self.taskCellVM.task.completed.toggle()
                }
                TextField("", text: self.$taskCellVM.task.title)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding(.vertical)
                
                Text(getPriorityIndicator(priority: self.taskCellVM.task.priority))
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding([.trailing, .vertical])
                
                Spacer()
            }
            .clipped()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(darkBackground)
                    .shadow(color: getPriorityColor(priority: self.taskCellVM.task.priority), radius: 5)
            )
                .offset(x: self.draggedOffset.width + self.lastOffset.width)
                .gesture(DragGesture(minimumDistance: 20)
                    .onChanged { value in
                        self.draggedOffset = value.translation
                }
                .onEnded { value in
                    let offset: CGSize
                    if (self.draggedOffset.width + self.lastOffset.width < -100) {
                        offset = CGSize(width: -150, height: 0)
                    } else {
                        offset = CGSize.zero
                    }
                    self.lastOffset = offset
                    self.draggedOffset = CGSize.zero
                })
                .frame(width: screenWidth * 0.90)
            
            
            // Info and Delete buttons
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding()
                }
                .clipped()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(blue)
                        .shadow(radius: 5)
                )
                .onTapGesture {
                        self.showingDetail.toggle()
                        self.detailTaskCellVM = self.taskCellVM
                        print("tapped info of \(self.taskCellVM.task.title)")
                }
                
                HStack {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding()
                }
                .clipped()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(red)
                        .shadow(radius: 5)
                )
                    .onTapGesture {
                        self.dayTaskVM.deleteTask(task: self.taskCellVM.task)
                }
            }
            .frame(width: screenWidth * 0.9)
            .offset(x: self.draggedOffset.width + self.lastOffset.width + 150)
            .gesture(DragGesture(minimumDistance: 20)
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                let offset: CGSize
                if (self.draggedOffset.width + self.lastOffset.width < -100) {
                    offset = CGSize(width: -150, height: 0)
                } else {
                    offset = CGSize.zero
                }
                self.lastOffset = offset
                self.draggedOffset = CGSize.zero
            })
                
            
            
        }
        .background(darkerBackground)
        
    }
}


struct FriendTaskView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var friendProfile: UserViewModel
    @ObservedObject var taskVM: TaskViewModel
    
    init(friendProfile: UserViewModel){
        self.friendProfile = friendProfile
        self.taskVM = TaskViewModel(taskRepository: TaskRepository(friendId: friendProfile.id))
    }
    
    init(friendProfile: UserViewModel, date: Date){
        self.friendProfile = friendProfile
        self.taskVM = TaskViewModel(taskRepository: TaskRepository(friendId: friendProfile.id, date: date))
    }
    
    var body: some View {
        VStack {
            // IDK WHY DOING THIS MAKES THE DATA LOAD
            Text("")
                .frame(width: screenWidth, height: 0)
            // FIGURE IT OUT FUTURE ME
            
            ForEach (taskVM.taskCellViewModels) { taskCellVM in
//                if self.viewRouter.dateShown.isSameDay(taskCellVM.task.dayAssigned) {
                    FriendTaskCellView(dayTaskVM: self.taskVM, taskCellVM: taskCellVM/*, showingDetail: self.$showingDetail, detailTaskCellVM: self.$detailTaskCellVM*/)
                        .padding([.horizontal,.bottom])
//                }
            }
        }
    }
}

struct FriendTaskCellView: View  {
    @ObservedObject var dayTaskVM: TaskViewModel
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var showInfo = false
    
    func getPriorityColor(priority: TaskPriority) -> Color {
        switch priority {
        case .none:
            return .black
        case .low:
            return green
        case .medium:
            return yellow
        case .high:
            return red
        }
    }
    
    func getPriorityIndicator(priority: TaskPriority) -> String {
        switch priority {
        case .none:
            return ""
        case .low:
            return "!"
        case .medium:
            return "!!"
        case .high:
            return "!!!"
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text(self.taskCellVM.task.title)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                
                Spacer()
                
                Text(getPriorityIndicator(priority: self.taskCellVM.task.priority))
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 5)
                    .padding([.trailing, .vertical])
            }
            .clipped()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(darkBackground)
                    .shadow(color: getPriorityColor(priority: self.taskCellVM.task.priority), radius: 5)
            )
                .offset(x: self.draggedOffset.width + self.lastOffset.width)
                .gesture(DragGesture(minimumDistance: 20)
                    .onChanged { value in
                        self.draggedOffset = value.translation
                }
                .onEnded { value in
                    let offset: CGSize
                    if (self.draggedOffset.width + self.lastOffset.width < -100) {
                        offset = CGSize(width: -80, height: 0)
                    } else {
                        offset = CGSize.zero
                    }
                    self.lastOffset = offset
                    self.draggedOffset = CGSize.zero
                })
                .frame(width: screenWidth * 0.90)
            
            // Info and Delete buttons
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .padding()
                }
                .clipped()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(blue)
                        .shadow(radius: 5)
                )
                
                
            }
            .frame(width: screenWidth * 0.9)
            .offset(x: self.draggedOffset.width + self.lastOffset.width + 80)
            .gesture(DragGesture(minimumDistance: 20)
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                let offset: CGSize
                if (self.draggedOffset.width + self.lastOffset.width < -100) {
                    offset = CGSize(width: -80, height: 0)
                } else {
                    offset = CGSize.zero
                }
                self.lastOffset = offset
                self.draggedOffset = CGSize.zero
            })
            
            
        }
        .background(darkerBackground)
        
    }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}

