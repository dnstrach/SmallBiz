//
//  Task.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/21/22.
//

import Foundation

//using codable class because JSONEncoder/JSONDecoder requires that 'Employee' conform to 'Encodable/Decodable'
class Task: Codable, Equatable {
    //properties
    var title: String
    var isComplete: Bool
    var id: String
    
    //initializer
    init(title: String, isComplete: Bool = false, id: String = UUID().uuidString) {
        self.title = title
        self.isComplete = isComplete
        self.id = id
    }
    
    //conforming to Codable & Equatable protocols
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}


