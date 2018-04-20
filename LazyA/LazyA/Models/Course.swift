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
        @objc dynamic var components : [Component] = [Component]()

        var totalWeight : Int {
            return self.components.compactMap { $0.weight }.reduce(0,+)
        }
        
        var neededWeight : Float {
            return Float(totalWeight * desiredGrade) / 100.0
        }
        
        var projectedEarnedWeight : Float {
            return self.components.compactMap { $0.projectedEarnedWeight  }.reduce(0,+)
        }
        
        var projectedRemainingWeight : Float {
            return neededWeight - projectedEarnedWeight
        }
        
        var currentGrade : Float {
            return projectedEarnedWeight / Float(totalWeight)
        }
        
        var finalScoreNeeded : Float {
            let finalComponent = self.components.filter { $0.isFinal }.first!
            return projectedRemainingWeight / Float(finalComponent.weight)
        }
    }

