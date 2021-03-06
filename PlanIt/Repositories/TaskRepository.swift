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
    @Published var tasks = [Task]()
    
    private var userId: String?
    
    let db = Firestore.firestore()
    
    init() {
        userId = Auth.auth().currentUser?.uid
        loadData()
    }
    
    init(date: Date) {
        userId = Auth.auth().currentUser?.uid
        loadData(date: date)
    }
    
    init(friendId: String) {
        userId = friendId
        loadData()
    }
    
    init(friendId: String, date: Date) {
        userId = friendId
        loadData(date: date)
    }
    
    func loadData() {
        db.collection("tasks")
            .order(by: "createdTime")
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
    
    func loadData(date: Date) {
        let begTimestamp = Timestamp(date: date.begDay())
        let endTimestamp = Timestamp(date: date.endDay())
        print("filtered date")
        db.collection("tasks")
            .order(by: "dayAssigned")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId as Any)
            .whereField("dayAssigned", isGreaterThanOrEqualTo: begTimestamp)
            .whereField("dayAssigned", isLessThanOrEqualTo: endTimestamp)
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
