//
//  CourseMenuViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 11/21/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//


struct CourseMenuViewModel {
    let courses = CourseHandler.shared.getAll()
    
    var numCourses : Int {
        return courses.count
    }
    
    func course( for row : Int) -> Course {
        return courses[row]
    }
}
