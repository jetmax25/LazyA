//
//  CreateCoursesViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

struct CreateCoursesViewModel {
    
    var selectedRow : Int?
    var courses = [Course]()
    
    var numCourses : Int {
        return self.courses.count
    }
    
    var selectedCourse : Course? {
        guard let row = selectedRow, row < numCourses else {
            return nil
        }
        return self.courses[row]
    }
    
    private mutating func createNewCourse( name : String, courseNum : String?, grade : Int) {
        let newCourse = Course()
        newCourse.name = name
        newCourse.courseCode = courseNum
        newCourse.desiredGrade = grade
        self.courses.append(newCourse)
    }
    
    private mutating func editCourse(course : Course, name : String, courseNum : String?, grade : Int) {
        course.name = name
        course.courseCode = courseNum
        course.desiredGrade = grade
    }
    
    mutating func updateCourse(grade : Int, name : String, courseCode : String?) {
        if let selectedRow = selectedRow, selectedRow < self.courses.count{
            editCourse(course: self.courses[selectedRow], name: name, courseNum: courseCode, grade: grade)
        } else {
            createNewCourse(name: name, courseNum: courseCode, grade: grade)
        }
    }
    
    func getCourseNameFor( row : Int) -> String {
        return self.courses[row].name
    }
    
    func getCourseGradeFor( row : Int) -> String {
        return "\(self.courses[row].desiredGrade)"
    }
    
    func saveCourses() {
        self.courses.forEach { course in try! AppDelegate.realm.write {
                AppDelegate.realm.add(course)
            } }
    }
}
