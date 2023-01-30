//
//  TaskController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/21/22.
//

import Foundation

class TaskController {
    
    //do not need to include source of truth
    //will be adding/deleting and updating tasks to/from the employee array?
    //here source of truth is singular
    
    //do not need shared instance because will not be creating new instances of a task when adding, deleting, or updating a task
    //BUT will not be modifying properties in this controller, therefore all functions can be static in this file
    //static function? can have both static properties and functions on a class or struct — static simply means that the function or property belongs to the TYPE of the class or struct, rather than an INSTANCE of the class
    //example: class/struct Hammer ---> Hammer.shape()...hammer already has a shape  //class/struct Hammer ---> Hammer.nail ERROR...need instance of hammer to nail something
    
    //CRUD - create
    //static function because belongs to the TaskController class
    //required arguments? (difference between param and arg) are the employee class and task title property
    //employee does not need an argument label
    static func assignTaskTo(_ employee: Employee, taskTitle: String) {
        
        //initialize new task with the Task class that requires task title
        let newTask = Task(title: taskTitle)
        
        //add taks to the employee's tasks property within the Employee class
        employee.tasks.append(newTask)
        
        //save method/function from employee controller
        EmployeeController.shared.saveToPersistenceStore()
    }
    
    //CRUD - delete method
    static func deleteTaskFrom(_ employee: Employee, _ task: Task) {
        //guard to prevent optional in firstIndex(of: _)
        //locating the first index in the tasks array property in the employee class
        guard let index = employee.tasks.firstIndex(of: task) else { return }
        
        //removing task object from the tasks array in the employee class
        employee.tasks.remove(at: index)
        
        //save
        EmployeeController.shared.saveToPersistenceStore()
        
    }
    
    //handles toggling of isComplete property
    static func toggleTaskStatus(employee: Employee, task: Task) {
        //double guard statement capturing index of employee from shared instance
        guard let taskIndex = employee.tasks.firstIndex(of: task),
                let employeeIndex = EmployeeController.shared.employees.firstIndex(of: employee) else { return }

        //indices to subscript source of truth and toggle isComplete property
        EmployeeController.shared.employees[employeeIndex].tasks[taskIndex].isComplete.toggle()

        //save
        EmployeeController.shared.saveToPersistenceStore()
    }
}
