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
    var courses : [Course] {
        return UserInfo.shared.courses
    }
    
    var currentCourse : Course? {
        if currentCourseNum < UserInfo.shared.courses.count {
            return UserInfo.shared.courses[currentCourseNum]
        }
        return nil
    }
    
    var courseName : String {
        return currentCourse!.name
    }
    
    var currentCourseNum : Int!
    
    init() {
        self.currentCourseNum = 0
    }
    
    var chartData : PieChartData {
        let dataList = currentCourse!.components.map{ return PieChartDataEntry(value: Double($0.weight), label: $0.name) }
        let dataSet = PieChartDataSet(values: dataList, label: nil)
        dataSet.colors = ChartColorTemplates.colorful()
        return PieChartData(dataSet: dataSet)
    }

    var numComponents : Int {
        return currentCourse!.components.count
    }
    
    mutating func createNewComponent() {
        currentCourse!.components.append( Component.init(weight: 20))
    }
    
    mutating func editComponent(for row : Int, name : String, weight : Int) {
        let course = currentCourse!.components[row]
        course.name = name
        course.weight = weight
    }
    
    mutating func nextCourse() {
        self.currentCourseNum = self.currentCourseNum + 1
    }
}
