//
//  Component.swift
//  LazyA
//
//  Created by Michael Isasi on 4/5/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import CoreData


    class Component : NSManagedObject {
       /* @NSManaged var name : String
        @NSManaged var weight : Int
        @NSManaged var assigments : [Models.Assignment]?*/
        
        init(name: String = "" , weight: Int) {
            let entityDescription: NSEntityDescription =  NSEntityDescription.entity(forEntityName: "Component", in: AppDelegate.viewContext)!
            
            super.init(entity: entityDescription, insertInto: AppDelegate.viewContext)
            self.name = name
            self.weight = Int64(weight)
        }
    }


