//
//  CreateComponentViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation
import Charts

struct CreateComponentViewModel {
    var courses : [Course]
    
    var currentCourse : Course? {
        if currentCourseNum < courses.count {
            return courses[currentCourseNum]
        }
        return nil
    }
    
    var courseName : String {
        return currentCourse!.name
    }
    
    var currentCourseNum : Int!
    
    init() {
        self.currentCourseNum = 0
        self.courses = Array(AppDelegate.realm.objects(Course.self))
        setUpDefaultCourses()
    }
    
    func setUpDefaultCourses() {
        if currentCourse?.catagories.count == 0 {
        standardComponents.forEach { catagory in
        try! AppDelegate.realm.write {
        currentCourse!.catagories.append(catagory)
        }
        }
        }
    }
    
    var chartData : PieChartData {
        let dataList = Array(currentCourse!.catagories).map{ return PieChartDataEntry(value: Double($0.weight), label: $0.name) }
        let dataSet = PieChartDataSet(values: dataList, label: nil)
        dataSet.colors = ChartColorTemplates.colorful()
        return PieChartData(dataSet: dataSet)
    }

    var numComponents : Int {
        return currentCourse!.catagories.count
    }
    
    func componentFor( row : Int ) -> Component? {
        return currentCourse?.catagories[row]
    }
    
    mutating func createNewComponent() {
        try! AppDelegate.realm.write {
            currentCourse!.catagories.append( Component() )
        }
    }
    
    mutating func editComponent(for row : Int, name : String, weight : Int) {
        try! AppDelegate.realm.write {
            let course = currentCourse!.catagories[row]
            course.name = name
            course.weight = weight
        }
    }
    
    mutating func nextCourse() {
        self.currentCourseNum = self.currentCourseNum + 1
        setUpDefaultCourses()
    }
    
    var standardComponents : [Component] {
        let test = Component()
        test.name = "Tests"
        test.weight = 35
        
        let quiz = Component()
        quiz.name = "Quizes"
        quiz.weight = 15
        
        let hw = Component()
        hw.name = "Homework"
        hw.weight = 10
        
        let assignments = Component()
        assignments.name = "Assignments"
        assignments.weight = 20
        
        let final = Component()
        final.isFinal = true
        final.name = "Final"
        final.weight = 25
        
        return [test, quiz, hw, assignments, final]
    }

}
