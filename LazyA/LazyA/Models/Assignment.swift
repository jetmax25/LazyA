//
//  Assignment.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation
import RealmSwift


//extension Models {
class Assignment : Object, Comparable {
    static func < (lhs: Assignment, rhs: Assignment) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func ==(lhs: Assignment, rhs: Assignment) -> Bool {
        return lhs.name == rhs.name
    }
    
    /// False if the each assignment is worth the number of points, set to true if no matter the points everything is worth the same
    @objc dynamic var normalizeTo100 : Bool = false
    /// Unique name of the assignemnt
    @objc dynamic var name : String = ""
    /// The most points that can be earned on the assignment. 100 if normalize to 100 is true
    @objc dynamic var maxPoints : Int = 100
    /// Weight of the assignment
    @objc dynamic var weight : Int = 100
    /// Grade the user wishes to receive on the assignemnt
    @objc dynamic var desiredGrade : Int = 90
    ///Number of points earned on teh assignment
    var earnedPoints = RealmOptional<Float>()
    ///Date the assignment is due
    @objc dynamic var dueDate : Date? = nil
    ///Default completion status of the assignment
    @objc dynamic private var _completionString : String = "Incomplete"
    ///Name of component that the assignment is attached to
    @objc dynamic var componentString : String = ""
    ///Name of the course that the assignment is attached to
    @objc dynamic var courseString : String = ""
    
    
    /** Returns whether the student has already taken the assignment
     - Important: Probably should use completion status to define in the future
    */
    var didTake : Bool {
        return earnedPoints.value != nil
    }
    
    /// Grade of the assignment as a percentage
    var percentGrade : Float {
        return self.earnedPoints.value.map { $0 / Float(maxPoints) } ?? 0
    }
    
    /** Returns the weighted points for an assignment
     - Important: Defined as the raw points if not normalized, otherwise is the percent grade as an int from 0-100
    */
    var weightedEarnedPoints : Float {
        return self.earnedPoints.value.map { normalizeTo100 ? percentGrade * 100 : $0 } ?? 0
    }
    
    
    /// The most weighted points that a user can earn on an assigment
    var weightedMaxPoints : Int {
        return normalizeTo100 ? 100 : maxPoints
    }
    
    
    /// Completion status of assigment, saved as a string
    var completionStatus : CompletionStatus {
        set {
            _completionString = completionStatus.rawValue
        }
        get {
            return CompletionStatus(rawValue: _completionString)!
        }
    }
}

extension Array where Element : Assignment {
    
    /// Groups assignment by date
    var seperatedByDate : [Date? : [Assignment]] {
        return Dictionary(grouping: self, by: { $0.dueDate })
    }
    
    ///Sorts assignments by date
    func sortedByDate() -> [Assignment] {
        return self.filter{ $0.dueDate == nil } + self.filter { $0.dueDate != nil }.sorted { $0.dueDate! < $1.dueDate! }
    }
    
    ///Gets all dates of the assignments
    var dates : [Date] {
        return Set(self.map { $0.dueDate }).compactMap{ $0 }.sorted()
    }
}
