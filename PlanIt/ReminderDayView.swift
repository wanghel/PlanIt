//
//  ReminderDayView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

//struct ReminderDayView: View {
//    @ObservedObject var taskStore = TaskStore()
//    @State var newToDo : String = ""
//    
//    var day: String
//    var color: Color
//    
//    var searchBar : some View {
//        HStack {
//            TextField("Enter in a new task", text: self.$newToDo)
//        }
//    }
//    
//    func addNewToDo() {
//        taskStore.tasks.append(Task(id: String(taskStore.tasks.count+1), toDoItem: newToDo, dateCreation: Date()))
//        self.newToDo = ""
//    }
//    
//    var body: some View {
//        VStack (spacing: 0.0){
//            HStack {
//                Text(day)
//                    .font(.title)
//                    .foregroundColor(.white)
//                Spacer()
//                Button(action: {self.addNewToDo()}) {
//                    Image(systemName: "square.and.pencil").renderingMode(.original)
//                }
//            }
//            .padding().frame(width: screenWidth, alignment: .leading)
//            .background(color)
//            
//            ScrollView() {
//                ForEach(taskStore.tasks) { task in
//                    HStack {
//                        Text(task.toDoItem)
//                        Spacer()
//                    }
//                    Divider()
//                }.padding([.top, .leading, .trailing])
//                self.searchBar.padding().background(Color.white)
//                
//            }
//            
//        }
//        
//    }
//    
//}
//
//struct ReminderDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderDayView(day: "Preview", color: Color.gray)
//    }
//}
