//
//  ReminderDayView.swift
//  PlanIt
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import SwiftUI

extension View {
 
    func navigationBarColor(backgroundColor: Color?) -> some View {
        return self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}

struct ReminderDayView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    
    var searchBar : some View {
        HStack {
            TextField("Enter in a new task", text: self.$newToDo)
            /*Button(action: self.addNewToDo, label: {Text("Add New")
            })*/
        }
    }
    
    func addNewToDo() {
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count+1), toDoItem: newToDo, dateCreation: Date()))
        self.newToDo = ""
    }
    
    var day: String
    var color: Color
    var body: some View {
        
        VStack (spacing: 0.0){
            searchBar.padding().background(Color.white)
            List(taskStore.tasks){ task in
                Text(task.toDoItem)
            }
            
        }
        .background(color)
            .navigationBarTitle(Text(day).foregroundColor(.white)
            .fontWeight(.thin)/*, displayMode: .inline*/)
        .navigationBarItems(trailing: Button("Add") {
            print("Add tapped!")
            self.addNewToDo()
            }).navigationBarColor(backgroundColor: self.color)
        
    }
    
}

struct ReminderDayView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDayView(day: "test", color: Color.gray)
    }
}
