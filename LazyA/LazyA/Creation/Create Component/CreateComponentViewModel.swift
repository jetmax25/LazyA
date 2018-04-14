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
    private var components : [Component] = [Component]()
    
    var chartData : PieChartData {
        let dataList = components.map{ return PieChartDataEntry(value: Double($0.weight), label: $0.name)}
        let dataSet = PieChartDataSet(values: dataList, label: nil)
        dataSet.colors = ChartColorTemplates.colorful()
        return PieChartData(dataSet: dataSet)
    }

    var numComponents : Int {
        return components.count
    }
    
    mutating func createNewComponent() {
        self.components.append( Component.init(weight: 20))
    }
    
    mutating func editComponent(for row : Int, name : String, weight : Int) {
        let course = components[row]
        course.name = name
      //  course.weight = weight
    }
    
//    mutating func updateComponent( name : String, weight : Int) {
//        createNewComponent(name: name, weight : weight)
//    }

    
}
