//
//  Assignment.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation
import CoreData

extension Models {
    class Assignment : NSManagedObject {
        static func ==(lhs: Assignment, rhs: Assignment) -> Bool {
            return lhs.name == rhs.name
        }
        
        @NSManaged var name : String
        @NSManaged var maxPoints : NSNumber
        @NSManaged var earnedPoints : NSNumber?
        
    }
}
