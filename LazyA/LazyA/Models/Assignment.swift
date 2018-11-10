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
    class Assignment : Object {
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
        
        
        var didTake : Bool {
            return earnedPoints.value != nil
        }
        
        var percentGrade : Float {
            return earnedPoints.value == nil ? 0 : earnedPoints.value! / Float(maxPoints)
        }
        
        var weightedEarnedPoints : Float {
            guard let earnedPoints = self.earnedPoints.value else {
                return 0
            }
            return normalizeTo100 ? percentGrade * 100 : earnedPoints
        }
        
        var weightedMaxPoints : Int {
            return normalizeTo100 ? 100 : maxPoints
        }
    }
//}
