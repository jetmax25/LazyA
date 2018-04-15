//
//  Course.swift
//  LazyA
//
//  Created by Michael Isasi on 3/9/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import CoreData


    class Course :  NSManagedObject  {
        @NSManaged var name : String
        @NSManaged var desiredGrade : Int16
        @NSManaged var courseCode : String?
        var components : [Component] = [Component]()

        
        init(name: String, expectedGrade : Int, courseCode : String? = nil) {
            let entityDescription: NSEntityDescription =  NSEntityDescription.entity(forEntityName: "Course", in: AppDelegate.viewContext)!

            super.init(entity: entityDescription, insertInto: AppDelegate.viewContext)
            self.name = name
            self.desiredGrade = Int16(expectedGrade)
            self.courseCode = courseCode
            self.components = [Component]()
        }
    }

