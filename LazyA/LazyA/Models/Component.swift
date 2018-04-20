//
//  Component.swift
//  LazyA
//
//  Created by Michael Isasi on 4/5/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import CoreData
import RealmSwift

    class Component : Object {
        @objc dynamic var name : String = ""
        @objc dynamic var weight : Int = 25
        @objc dynamic var isFinal : Bool = false
        var assigments : [Assignment] = [Assignment]()
        
        var completedAssignments : [Assignment] {
            return self.assigments.filter { $0.didTake }
        }
        
        var remainingAssignemnts : [Assignment] {
            return self.assigments.filter { !$0.didTake }
        }
        
        var earnedSum : Float {
            return completedAssignments.compactMap { $0.weightedEarnedPoints }.reduce(0,+)
        }
        
        var earnedMaxSum : Int {
            return completedAssignments.compactMap { $0.weightedMaxPoints }.reduce(0,+)
        }
        
        var totalMaxSum : Int {
            return self.assigments.compactMap { $0.weightedMaxPoints }.reduce(0,+)
        }
        
        var currentPercentGrade : Float {
            return earnedSum / Float(earnedMaxSum)
        }
        
        var earnedWeight : Float {
            return earnedSum / Float(totalMaxSum) * Float(weight)
        }
        
        var projectedEarnedWeight : Float {
            return currentPercentGrade * Float(weight)
        }
    }


