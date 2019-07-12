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
        var assigments = List<Assignment>()
        
        
        /// Assignments that have been completed (or missed)
        var completedAssignments : [Assignment] {
            return self.assigments.filter { $0.didTake }
        }
        
        
        /// Assignments left in the course
        var remainingAssignemnts : [Assignment] {
            return self.assigments.filter { !$0.didTake }
        }
        
        
        /// The total wighted points the user has recieved for the completed assignments
        var earnedSum : Float {
            return completedAssignments.compactMap { $0.weightedEarnedPoints }.reduce(0,+)
        }
        
        
        /// The total possible points the user could have recieved for the cmpleted assignments
        var earnedMaxSum : Int {
            return completedAssignments.compactMap { $0.weightedMaxPoints }.reduce(0,+)
        }
        
        
        /// The total sum of points the user could possibly recieve on all assignments completed or not
        var totalMaxSum : Int {
            return self.assigments.compactMap { $0.weightedMaxPoints }.reduce(0,+)
        }
        
        
        /// The current grade of the user 0-100
        var currentPercentGrade : Float {
            return earnedSum / Float(earnedMaxSum)
        }
        
        
        /// The wieghted component points a user has recieved
        var earnedWeight : Float {
            return earnedSum / Float(totalMaxSum) * Float(weight)
        }
        
        
        /// The projected weight that a user will own for a component
        var projectedEarnedWeight : Float {
            return currentPercentGrade * Float(weight)
        }
    }


