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
    //@EnvironmentObject var session: SessionStore
    @State var showingDetail = false
    @State var detailTaskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()))
    
    @ObservedObject var dayTaskVM = TaskViewModel()
    
    private var dayFromCurr: Int = 0
    
    init() {}
    
    init(dayFromCurr: Int) {
        self.dayFromCurr = dayFromCurr
    }
    
    
    var body: some View {
        //ScrollView {
        VStack {
            // IDK WHY DOING THIS MAKES THE DATA LOAD
            Text("")
                .frame(width: screenWidth, height: 0)
            // FIGURE IT OUT FUTURE ME
            
            ForEach (dayTaskVM.taskCellViewModels) { taskCellVM in
                if self.viewRouter.dateShown.addingTimeInterval(TimeInterval(self.dayFromCurr * 86400)).isSameDay(taskCellVM.task.dayAssigned) {
                    TaskCell(dayTaskVM: self.dayTaskVM, taskCellVM: taskCellVM, showingDetail: self.$showingDetail, detailTaskCellVM: self.$detailTaskCellVM)
                        .padding([.horizontal,.bottom])
                        .onDisappear(perform: {
                            if taskCellVM.task.completed {
                                self.dayTaskVM.deleteTask(task: taskCellVM.task)
                            }})
                }
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
    //var onCommit: (Task) -> (Void) = {_ in }
    
    @State private var draggedOffset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var showInfo = false
    
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
                TextField("", text: self.$taskCellVM.task.title/*, onCommit: {
                    self.onCommit(self.taskCellVM.task)
                }*/)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding()
                Spacer()
            }
            .clipped()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(navy)
                    .shadow(radius: 5)
            )
                .offset(x: self.draggedOffset.width + self.lastOffset.width)
                .gesture(DragGesture(minimumDistance: 30)
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
            .offset(x: self.draggedOffset.width + self.lastOffset.width + 150)
            .gesture(DragGesture(minimumDistance: 30)
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
        
    }
}


struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
