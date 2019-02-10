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
    
    @objc dynamic var normalizeTo100 : Bool = false
    @objc dynamic var name : String = ""
    @objc dynamic var maxPoints : Int = 100
    @objc dynamic var weight : Int = 100
    @objc dynamic var desiredGrade : Int = 90
    var earnedPoints = RealmOptional<Float>()
    @objc dynamic var dueDate : Date? = nil
    @objc dynamic private var _completionString : String = "Incomplete"
    @objc dynamic var componentString : String = ""
    @objc dynamic var courseString : String = ""
    
    var didTake : Bool {
        return earnedPoints.value != nil
    }
    
    var percentGrade : Float {
        return self.earnedPoints.value.map { $0 / Float(maxPoints) } ?? 0
    }
    
    var weightedEarnedPoints : Float {
        return self.earnedPoints.value.map { normalizeTo100 ? percentGrade * 100 : $0 } ?? 0
    }
    
    var weightedMaxPoints : Int {
        return normalizeTo100 ? 100 : maxPoints
    }
    
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
    var seperatedByDate : [Date? : [Assignment]] {
        return Dictionary(grouping: self, by: { $0.dueDate })
    }
    
    func sortedByDate() -> [Assignment] {
        return self.filter{ $0.dueDate == nil } + self.filter { $0.dueDate != nil }.sorted { $0.dueDate! < $1.dueDate! }
    }
    
    var dates : [Date] {
        return Set(self.map { $0.dueDate }).compactMap{ $0 }.sorted()
    }
}
