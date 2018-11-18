//
//  CourseHandler.swift
//  LazyA
//
//  Created by Michael Isasi on 11/18/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

class CourseHandler {
    static var shared = CourseHandler()
    
    private init() {
    }
    
    func add(_ course : Course ) {
        RealmHandler.shared.add(object: course)
    }
    
    func getAll() -> [Course] {
        return RealmHandler.shared.getAll()
    }
    
    func add( component : Component?, to course : Course?) {
        guard let component = component, let course = course else {
            return
        }
        RealmHandler.shared.perform {
            course.catagories.append(component)
        }
    }
    
    func addNewComponent( to course : Course? ) {
        self.add(component: Component(), to: course)
    }
}


extension CourseHandler {
    func update(component : Component?, name : String, weight : Int) {
        guard let component = component else {
            return
        }
        RealmHandler.shared.perform {
            component.name = name
            component.weight = weight
        }
    }
}
