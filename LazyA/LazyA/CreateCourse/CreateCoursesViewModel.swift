//
//  CreateCoursesViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

struct CreateCoursesViewModel {
    var courses : [Models.Course] = [Models.Course]()
    var selectedRow : Int?
    
    var numCourses : Int {
        return courses.count
    }
    
    var selectedCourse : Models.Course? {
        guard let row = selectedRow, row < numCourses else {
            return nil
        }
        return courses[row]
    }
    
    private mutating func createNewCourse( name : String, courseNum : String?, grade : Int) {
        let newCourse = Models.Course.init(name: name, expectedGrade: grade, courseCode: courseNum)
        self.courses.append(newCourse)
    }
    
    private mutating func editCourse(course : Models.Course, name : String, courseNum : String?, grade : Int) {
        course.name = name
        course.courseCode = courseNum
        course.desiredGrade = grade
    }
    
    mutating func updateCourse(grade : Int, name : String, courseCode : String?) {
        if let selectedRow = selectedRow{
            editCourse(course: courses[selectedRow], name: name, courseNum: courseCode, grade: grade)
        } else {
            createNewCourse(name: name, courseNum: courseCode, grade: grade)
        }
    }
    
    func getCourseNameFor( row : Int) -> String {
        return courses[row].name
    }
    
    func getCourseGradeFor( row : Int) -> String {
        return "\(courses[row].desiredGrade)"
    }
    
}
