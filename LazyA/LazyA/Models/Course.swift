//
//  Course.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

struct Course {
    var name : String
    var components : [Component]
    
    
    init(name : String = "", components : [Component] = [Component]()) {
        self.name = name
        self.components = components
    }
}
