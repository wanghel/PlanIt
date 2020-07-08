//
//  DayView.swift
//  PlanIt
//
//  Created by Helen Wang on 6/12/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI
import Firebase

//struct DayView: View {
//    @EnvironmentObject var viewRouter: ViewRouter
//    
//    @ObservedObject var taskVM = DayTaskViewModel()
//    
//    @State var presentAddNewItem = false
//    @State var showingDetail = false
//    @State var detailedTaskCellVM = TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: Date()))
//    
//    func printTime(hour: Int) -> String {
//        return "\(hour%12 == 0 ? 12 : hour%12) \(hour/12 == 0 ? "AM" : "PM")"
//    }
//    
//    var body: some View {
//        VStack (spacing:0) {
//            DayBarView()
//            
//            List {
//                ForEach(dayTaskVM.taskCellViewModels) { taskCellVM in
//                    if self.viewRouter.dateShown.isSameDay(taskCellVM.task.dayAssigned) {
//                        TaskCell(taskCellVM: taskCellVM, showingDetail: self.$showingDetail, detailedTaskCellVM: self.$detailedTaskCellVM)
//                            .onDisappear(perform: {
//                                if taskCellVM.task.completed {
//                                    self.dayTaskVM.deleteTask(task: taskCellVM.task)
//                                }})
//                    }
//                }
//                if presentAddNewItem {
//                    TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false, dayAssigned: self.viewRouter.dateShown)), showingDetail: $showingDetail, detailedTaskCellVM: $detailedTaskCellVM) { task in
//                        if(task.title != "") {
//                            self.dayTaskVM.addTask(task: task)
//                        }
//                        self.presentAddNewItem.toggle()
//                    }
//                }
//                
//                if !presentAddNewItem {
//                    Button (action: {
//                        self.presentAddNewItem.toggle()
//                    }) {
//                        Spacer()
//                    }
//                }
//                
//            }
//            
//        }
//        .edgesIgnoringSafeArea(.vertical)
//        .offset(x: viewRouter.isShowingDayView ? 0 : -screenWidth)
//        .sheet(isPresented: self.$showingDetail) {
//            DetailView(showingDetail: self.$showingDetail, taskCellVM: self.detailedTaskCellVM)
//        }
//        
//    }
//}
//
//
//struct TaskCell3: View  {
//    @ObservedObject var dayTaskVM: DayTaskViewModel
//    @ObservedObject var taskCellVM: TaskCellViewModel
//    @Binding var showingDetail: Bool
//    @Binding var detailTaskCellVM: TaskCellViewModel
//    //var onCommit: (Task) -> (Void) = {_ in }
//    
//    @State private var draggedOffset = CGSize.zero
//    @State private var lastOffset = CGSize.zero
//    @State private var showInfo = false
//    
//    var body: some View {
//        ZStack {
//            HStack {
//                Image(systemName: self.taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
//                    .resizable()
//                    .frame(width: 25, height: 25)
//                    .foregroundColor(.white)
//                    .padding()
//                    .onTapGesture {
//                        self.taskCellVM.task.completed.toggle()
//                }
//                TextField("", text: self.$taskCellVM.task.title/*, onCommit: {
//                    self.onCommit(self.taskCellVM.task)
//                }*/)
//                    .foregroundColor(.white)
//                    .font(.system(size: 20))
//                    .padding()
//                Spacer()
//            }
//            .clipped()
//            .background(
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(navy)
//                    .shadow(radius: 5)
//            )
//                .offset(x: self.draggedOffset.width + self.lastOffset.width)
//                .gesture(DragGesture(minimumDistance: 30)
//                    .onChanged { value in
//                        self.draggedOffset = value.translation
//                }
//                .onEnded { value in
//                    let offset: CGSize
//                    if (self.draggedOffset.width + self.lastOffset.width < -100) {
//                        offset = CGSize(width: -150, height: 0)
//                    } else {
//                        offset = CGSize.zero
//                    }
//                    self.lastOffset = offset
//                    self.draggedOffset = CGSize.zero
//                })
//            
//            
//            // Info and Delete buttons
//            HStack {
//                Spacer()
//                HStack {
//                    Image(systemName: "info.circle")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                .clipped()
//                .background(
//                    RoundedRectangle(cornerRadius: 15)
//                        .fill(blue)
//                        .shadow(radius: 5)
//                )
//                .onTapGesture {
//                        self.showingDetail.toggle()
//                        self.detailTaskCellVM = self.taskCellVM
//                        print("tapped info of \(self.taskCellVM.task.title)")
//                }
//                
//                HStack {
//                    Image(systemName: "trash")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                .clipped()
//                .background(
//                    RoundedRectangle(cornerRadius: 15)
//                        .fill(red)
//                        .shadow(radius: 5)
//                )
//                    .onTapGesture {
//                        self.dayTaskVM.deleteTask(task: self.taskCellVM.task)
//                }
//            }
//            .offset(x: self.draggedOffset.width + self.lastOffset.width + 150)
//            .gesture(DragGesture(minimumDistance: 30)
//            .onChanged { value in
//                self.draggedOffset = value.translation
//            }
//            .onEnded { value in
//                let offset: CGSize
//                if (self.draggedOffset.width + self.lastOffset.width < -100) {
//                    offset = CGSize(width: -150, height: 0)
//                } else {
//                    offset = CGSize.zero
//                }
//                self.lastOffset = offset
//                self.draggedOffset = CGSize.zero
//            })
//            
//            
//        }
//        
//    }
//}
//
//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
//
