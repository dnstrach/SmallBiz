//
//  Employee.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/20/22.
//

import Foundation

//blueprint for creating an employee
//using codable class because JSONEncoder/JSONDecoder requires that 'Employee' conform to 'Encodable/Decodable'
class Employee: Codable, Equatable {
    
    //blueprint for variable types
    //properties
    var firstName: String
    var lastName: String
    //added task after creating task model
    var tasks: [Task]
    var skillLevel: Int
    var id: String
    
    //run initializer method each time song instance is created
    //takes in info/parameters and assigns properties
    //assign parameters values containing specified types
    //setting defaults to skill level and id
    init(firstName: String, lastName: String, tasks: [Task] = [], skillLevel: Int = 0, id: String = UUID().uuidString) {
        self.firstName = firstName
        self.lastName = lastName
        self.tasks = tasks
        self.skillLevel = skillLevel
        self.id = id
    }
    
    //inializing employees/instances of employee
//    let newEmployee = Employee(firstName: "Brittany", lastName: "Strachan")
//    let secondEmployee = Employee(firstName: "Rostin", lastName: "Kohnechi", skillLevel: 5, id: 107890)
//
//    print(newEmployee.firstName)
    
    // Equatable Conformance
    //using id because will never be duplicates
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
}
