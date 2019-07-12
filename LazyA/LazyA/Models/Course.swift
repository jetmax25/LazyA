//
//  Course.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import CoreData
import RealmSwift

class Course : Object {
    
    /// Name of the course
    /// - Important: Doesnt neeed to be unique
    @objc dynamic var name : String = ""
    /// Grade the user wishes to recieve for the course
    @objc dynamic var desiredGrade : Int = 90
    /// Abbriviation for the coures
    @objc dynamic var courseCode : String? = nil
    
    /// Whether the course is broken up into unique categories: IE: HW, Tests
    @objc dynamic var hasCatagories : Bool = true
    
    /// Unique course identifier
    @objc dynamic var key = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    /// List of catagories that the course contains
    let catagories = List<Component>()

    
    /// The weight of all categories in the course combined. If there are no categories its the wieght of all assignemnts
    var totalWeight : Int {
        return self.catagories.compactMap { $0.weight }.reduce(0,+)
    }
    
    /// The weight that a user must get to achiece their desired grade
    var neededWeight : Float {
        return Float(totalWeight * desiredGrade) / 100.0
    }
    
    
    /// <#Description#>
    var projectedEarnedWeight : Float {
        return self.catagories.compactMap { $0.projectedEarnedWeight  }.reduce(0,+)
    }
    
    
    /// The ammount of weight the user needs in addition to what theyve earned to get their expected grade
    var projectedRemainingWeight : Float {
        return neededWeight - projectedEarnedWeight
    }
    
    
    /// The grade the user currently has as determined by completed items
    var currentGrade : Float {
        if totalWeight == 0 {
            return 0
        }
        return projectedEarnedWeight / Float(totalWeight)
    }
    
    
    /// The score the user needs on their final in order to get the grade they want for the class
    var finalScoreNeeded : Float {
        let finalComponent = self.catagories.filter { $0.isFinal }.first!
        return projectedRemainingWeight / Float(finalComponent.weight)
    }
}

extension Course {

    private weak var savedObject : Course? {
        return CourseHandler.shared.getCourse(self.key)
    }
    
    func save() {
        if let savedObject = self.savedObject {
            RealmHandler.shared.perform {
                savedObject.name = name
                savedObject.desiredGrade = desiredGrade
                savedObject.courseCode = courseCode
                savedObject.hasCatagories = hasCatagories
            }
        } else {
           CourseHandler.shared.add(self)
        }
    }
    
    func delete() {
        CourseHandler.shared.delete(self)
    }
    
    func add( component : Component ) {
        CourseHandler.shared.add(component: component, to: self)
    }
    
    var assignments : Set<Assignment> {
        return Set(self.catagories.compactMap{ $0.assigments }.joined())
    }
}
