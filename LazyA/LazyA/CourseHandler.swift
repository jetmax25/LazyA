//
//  CourseHandler.swift
//  LazyA
//
//  Created by Michael Isasi on 11/18/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import RealmSwift
class CourseHandler {
    static var shared = CourseHandler()
    
    private init() {
    }
    
    func add(_ course : Course ) {
        RealmHandler.shared.add(object: course)
    }
    
    func delete(_ course : Course ) {
        RealmHandler.shared.delete(object: course)
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
    
    func getCourse( _ key : String ) -> Course? {
        return RealmHandler.shared.get(key)
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
    
    private func course(for component : Component ) -> Course?{
        let pred = NSPredicate(format: "ANY catagories.name = %@", argumentArray: [component.name])
        let course : Course? = RealmHandler.shared.get(where: pred)
        return course
    }
    
    func delete(_ component : Component ) {
        if let course = self.course(for: component), let index = course.catagories.index(of: component) {
            RealmHandler.shared.perform {
                course.catagories.remove(at: index)
            }
        }
        RealmHandler.shared.delete(object: component)
    }
    
    func getAllComponents() -> [Component] {
        return RealmHandler.shared.getAll()
    }
}

extension CourseHandler {
    func getAllAssignments() -> [Assignment] {
        return RealmHandler.shared.getAll()
    }
}
