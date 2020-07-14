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
    
    let db = Firestore.firestore()
    
    init() {
//        print("Created another taskrepository")
        loadData()
    }
    
    init(date: Date) {
    //        print("Created another taskrepository")
            loadData(date: date)
    }
    
    init(friendId: String) {
        loadData(friendId: friendId)
    }
    
    init(friendId: String, date: Date) {
        loadData(friendId: friendId, date: date)
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
//        print(userId ?? "no user")
//        print("loading data")
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
        let userId = Auth.auth().currentUser?.uid
//            let timestamp = Timestamp(date: date)
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
    
    func loadData(friendId: String) {
//            print(friendId ?? "no user")
//            print("loading data")
            db.collection("tasks")
                .order(by: "createdTime")
                .whereField("userId", isEqualTo: friendId as Any)
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
    
    func loadData(friendId: String, date: Date) {
        let begTimestamp = Timestamp(date: date.begDay())
        let endTimestamp = Timestamp(date: date.endDay())
        
        db.collection("tasks")
            .order(by: "dayAssigned")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: friendId as Any)
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
