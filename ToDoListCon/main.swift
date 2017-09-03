//
//  main.swift
//  ToDoListCon
//
//  Created by Володимир on 9/3/17.
//  Copyright © 2017 Володимир. All rights reserved.
//
//

import Foundation

print("Welcome to TODOList Application")
print("Commands: (A)dd (D)elete (E)dit (I)nsert (L)ist (Q)uit")
var taskList: [String] = []
var end = false
var option:String?


// Return text of new task
func newTask() -> String {
    print("Enter the Task:")
    var task = readLine()!
    while taskList.contains(task) {
        print("This task already entered! Enter another:")
        task = readLine()!
    }
    return task
}

//Returns the serial number of the selected item in the list
func selectItem(list:[String], msg: String) -> Int?{
    
    print("Enter No. task to \(msg):")
    
    var numberIndex:Int? = Int(readLine()!)
    
    while numberIndex==nil  {
        print("Incorect number")
        numberIndex = Int(readLine()!)
    }
    if numberIndex!>taskList.count-1 {
        print("No such element! See all tasks?(y/n)")
        let answer = readLine()
        if answer=="y"||answer=="Y" {
            printList(list: taskList)
            return selectItem(list: list, msg: msg)
        } else {
            return nil
        }
    }
    return numberIndex

}

//Print all emenetnt in list
func printList(list:[String]){
    print("No. \t Task:")
    for (index, task) in list.enumerated(){
        print("\(index) \t\(task)")
    }
}

//Edit element of list 
//editIndex (0..) - element
func editTask(editIndex: Int){
    print("Previous[\(editIndex)]: \(taskList[editIndex])")
    let task = newTask()
    if task != "" {
        taskList[editIndex] = task
    }
}

//Manin loop
while !end {
    print(">", terminator:"")
    option = readLine()
    switch option! {
        case "a","A":
            taskList.append(newTask())
        case "d","D":
            if taskList.count > 1 {
                if let deleteNo = selectItem(list: taskList, msg: "delete") {
                    taskList.remove(at: deleteNo)
                }
            } else if taskList.count == 1 {
                   taskList.removeAll()
            } else {
                print("List is empty")
            }
        
        case "e","E":
            if taskList.count > 1 {
                if let editNo = selectItem(list: taskList, msg: "edit") {
                    editTask(editIndex: editNo)
                }
            } else if taskList.count == 1 {
                editTask(editIndex: 0)
            } else {
                print("List is empty")
            }
        case "i","I":
            if taskList.count > 0 {
                if let insertNo = selectItem(list: taskList, msg: "insert") {
                    taskList.insert(newTask(), at: insertNo)
                }
            } else {
            print("List is empty")
            }
        case "l","L":
            printList(list: taskList)
        case "q","Q":
            end = true
    default:
        print("Incorrect command!")
        print("Commands: (A)dd (D)elete (E)dit (I)nsert (L)ist (Q)uit")
    }
}



