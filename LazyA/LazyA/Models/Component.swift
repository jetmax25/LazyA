//
//  Component.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//


struct Component : Equatable {
    static func ==(lhs: Component, rhs: Component) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name : String
    var weight : Int
    var assigments : [Assignment]
    
    init( name : String = "", weight : Int = 0, assigments : [Assignment] = [Assignment]()) {
        self.name = name
        self.weight = weight
        self.assigments = assigments
    }
}
