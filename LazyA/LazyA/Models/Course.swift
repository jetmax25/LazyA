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
    @objc dynamic var name : String = ""
    @objc dynamic var desiredGrade : Int = 90
    @objc dynamic var courseCode : String? = nil
    @objc dynamic var hasCatagories : Bool = true
    @objc dynamic var key = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
    let catagories = List<Component>()

    var totalWeight : Int {
        return self.catagories.compactMap { $0.weight }.reduce(0,+)
    }
    
    var neededWeight : Float {
        return Float(totalWeight * desiredGrade) / 100.0
    }
    
    var projectedEarnedWeight : Float {
        return self.catagories.compactMap { $0.projectedEarnedWeight  }.reduce(0,+)
    }
    
    var projectedRemainingWeight : Float {
        return neededWeight - projectedEarnedWeight
    }
    
    var currentGrade : Float {
        if totalWeight == 0 {
            return 0
        }
        return projectedEarnedWeight / Float(totalWeight)
    }
    
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
