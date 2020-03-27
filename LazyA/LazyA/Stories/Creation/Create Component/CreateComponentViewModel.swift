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
    var components : [Component] = [Component]()
    
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
        self.courses = CourseHandler.shared.getAll()
        setUpDefaultCourses()
    }
    
    mutating func setUpDefaultCourses() {
        components = self.standardComponents
    }
    
    var chartData : PieChartData {
        let dataList = Array(currentCourse!.catagories).map{ return PieChartDataEntry(value: Double($0.weight), label: $0.name) }
        let dataSet = PieChartDataSet(entries: dataList, label: nil)
        dataSet.colors = ChartColorTemplates.colorful()
        return PieChartData(dataSet: dataSet)
    }

    var numComponents : Int {
        return self.components.count
    }
    
    func componentFor( row : Int ) -> Component? {
        return self.components[row]
    }
    
    mutating func createNewComponent() {
        self.components.insert(Component(), at: 0)
    }
    
    mutating func deleteComponent( at row : Int) {
        self.components.remove(at: row)
    }
    
    mutating func editComponent(for row : Int, name : String, weight : Int) {
        let component = currentCourse!.catagories[row]
        component.name = name
        component.weight = weight
    }
    
    mutating func nextCourse() {
        saveComponents()
        self.currentCourseNum = self.currentCourseNum + 1
        setUpDefaultCourses()
    }
    
    func saveComponents() {
        for component in self.components {
            self.currentCourse?.add(component: component)
        }
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
