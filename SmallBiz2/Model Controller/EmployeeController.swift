//
//  EmployeeController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/20/22.
//

import Foundation

//controller where we can manipulate employees...CRUD

class EmployeeController {
    
    //shared instance
    //static creates a class property rather than instance property which provides access to other files?
    //calling on this method - EmployeeController() will provide access to all the functions in the class EmployeeController
    static let shared = EmployeeController()
    
    //source of truth - all of data displayed comes from employee array
    //var because array will change (add/delete employees)
    //empty array will contain employee objects
    var employees: [Employee] = []
    
    var defaultItems: [String] = [
            "Payroll",
            "Onboarding",
            "Employee Profile",
            "Work shoes",
        ]
    
    //CRUD methods/functions
    //Create - create or add
    //Read - have info stored on cloud server or website and read/pull data and convert into employee
    //Update
    //Delete
    
    //create function
    //need first name and last name parameters
    func addEmployee(firstName: String, lastName: String) {
        //declaring new employee object/creating employee instance
        //can set new instance to values because in model specified types and value names
        let newEmployee = Employee(firstName: firstName, lastName: lastName)
        
        // NEW
        if UserDefaults.standard.bool(forKey: "New Employee default items") {
            let tasks: [Task] = defaultItems.compactMap ( { Task(title: $0) })
            newEmployee.tasks = tasks
        }
        
        // Add newEmployee to our source of truth/employees array
        employees.append(newEmployee)
        //message will print when employee is added
        print("Successfully added a \(newEmployee.firstName) to our list of employees.")
        
        // Save
        saveToPersistenceStore()
        
    }
    
    //delete function
    //firstIndex(of: ) - finds first object in employees array - needs to be equatable to get access
    //use equatable to match deleted song to song in array to remove correct index
    //add equatable in model
    func deleteEmployee(employee: Employee) {
        //guard to prevent int optional
        //having equatable now allows for firstIndex(of: )
        guard let index = employees.firstIndex(of: employee) else { return }
        
        // Remove employee from employees array with index variable
        employees.remove(at: index)
        print("Successfully removed \(employee.firstName).")
        
        //save modified data
        saveToPersistenceStore()

    }
    
    //MARK - Persistence - saving modified data when exiting and opening app
    
    //Persistence Store - location where info is being stored
    func persistentStore() -> URL {
        //file manager on device
        //finding available URL saved in user's document directory and domain mask (where personal items are stored)
        //urls because array of urls - selecting url to save data to
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //storing data as JSON in first URL
        //json structure with key-value pairs
        //OS knows how to handle json
        let fileURL = urls[0].appendingPathComponent("SmallBiz.json")
        return fileURL
    }
    
    //Save
    //call on function in add and delete functions
    func saveToPersistenceStore() {
        //"do something"
        do {
            //take employee objects and turn into data
            //change employee model object to coadable to conform
            //throw error with out try
            //add do try catch block
            let data = try JSONEncoder().encode(employees)
            //try does something with the data
            //write to URL in persistentStore2
            try data.write(to: persistentStore())
        //catch error
        } catch {
            print("We had an error saving to our persistence store")
            //statement with error for more description
            print(error)
            //error thrown by write error
            print(error.localizedDescription)
        }
    }
    
    //Load
    //go to URL and turn data back into array of employees
    //need do try catch block or else throws error
    //add load to viewDidLoad function
    func loadFromPersistenceStore() {
        do {
            //get/capture data from specific URL
            let data = try Data(contentsOf: persistentStore())
            //decode data to turn back into employees array
            //structured as array with employee objects .self to assign type and from URL in persistentStore
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print("We had an error loading our data from the persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
}
