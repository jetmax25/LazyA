//
//  CreateCoursesViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

struct CreateCoursesViewModel {
    
    var selectedRow : Int?
    
    var numCourses : Int {
        return UserInfo.shared.courses.count
    }
    
    var selectedCourse : Course? {
        guard let row = selectedRow, row < numCourses else {
            return nil
        }
        return UserInfo.shared.courses[row]
    }
    
    private mutating func createNewCourse( name : String, courseNum : String?, grade : Int) {
        let newCourse = Course.init(name: name, expectedGrade: grade, courseCode: courseNum)
        UserInfo.shared.courses.append(newCourse)
    }
    
    private mutating func editCourse(course : Course, name : String, courseNum : String?, grade : Int) {
        course.name = name
        course.courseCode = courseNum
        course.desiredGrade = Int16(grade)
    }
    
    mutating func updateCourse(grade : Int, name : String, courseCode : String?) {
        if let selectedRow = selectedRow, selectedRow < UserInfo.shared.courses.count{
            editCourse(course: UserInfo.shared.courses[selectedRow], name: name, courseNum: courseCode, grade: grade)
        } else {
            createNewCourse(name: name, courseNum: courseCode, grade: grade)
        }
    }
    
    func getCourseNameFor( row : Int) -> String {
        return UserInfo.shared.courses[row].name
    }
    
    func getCourseGradeFor( row : Int) -> String {
        return "\(UserInfo.shared.courses[row].desiredGrade)"
    }
}
