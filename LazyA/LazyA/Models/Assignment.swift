//
//  Assignment.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation

struct Assignment : Equatable {
    static func ==(lhs: Assignment, rhs: Assignment) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name : String
    let maxPoints : Int
    var earnedPoints : Int?
    
    init( name : String = "", maxPoints : Int = 100, earnedPoints : Int? = nil) {
        self.name = name
        self.maxPoints = maxPoints
        self.earnedPoints = earnedPoints
    }
}
