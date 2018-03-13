//
//  CourseViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

class CourseViewModel {
    var model : Course
    
    init() {
        self.model = Course()
    }
    
    func changeCourseName( name : String ){
        self.model.name = name
    }
    
    func change( component : Component, name : String?, weight : Int? ) -> Bool {
        guard (self.model.components.contains { $0.name == name }),
            let index = getIndex(of: component) else {
            return false
        }

        if let name = name {
            self.model.components[index].name = name
        }
        
        if let weight = weight {
            self.model.components[index].weight = weight
        }
        
        return true
    }
    
    func addComponent( name : String = "", weight : Int = 0 )
    {
        self.model.components.append( Component(name: name, weight: weight))
    }
    
    func getComponent( at index : Int) -> Component? {
        guard index < self.model.components.count else {
            return nil
        }
        return self.model.components[index]
    }
    
    func getAssigment( for component : Component, at index : Int ) -> Assignment? {
        guard index < component.assigments.count else {
            return nil
        }
        return component.assigments[index]
    }
    
    func getIndex( of component : Component) -> Int? {
        return self.model.components.index(of : component)
    }
    
    func getIndex( of assigment : Assignment, for component : Component) -> Int? {
        return component.assigments.index(of : assigment)
    }
}
