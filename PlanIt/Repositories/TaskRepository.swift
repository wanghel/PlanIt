//
//  TaskRepository.swift
//  PlanIt
//
//  Created by Helen Wang on 6/16/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        print("Created another taskrepository")
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        print(userId ?? "no user")
        print("loading data")
        db.collection("tasks")
//            .order(by: "dayAssigned")
            .order(by: "createdTime")
//            .whereField("dayAssigned", isGreaterThanOrEqualTo: Timestamp(date: from))
//            .whereField("dayAssigned", isLessThan: Timestamp(date: to))
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
                if let qs = querySnapshot {
                    self.tasks = qs.documents.compactMap {
                        document in
                        do {
                            let x = try document.data(as: Task.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
                
        }
    }
    
//    func reloadData() {
//        loadData()
//        print("reload data")
//    }
    
    func addTask(_ task: Task) {
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTask(_ task: Task) {
        if let taskID = task.id {
            db.collection("tasks").document(taskID).delete()
        }
    }
    
    
}
