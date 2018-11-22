//
//  ComponentPicker.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import Foundation

protocol ComponentPickerDelegate : class {
    func ComponentPicker( componentPicker : ComponentPicker, didSelect component : String)
}

class ComponentPicker: UIPickerView {
    
    weak var componentDelegate : ComponentPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.clear
    }
    
    var course : Course? {
        didSet {
            if let course = course {
                components = Array(Set(course.catagories).map { $0.name }).sorted { $0 < $1 }
            } else {
                components = Array(Set(CourseHandler.shared.getAllComponents().map { $0.name })).sorted { $0 < $1 }
            }
            self.reloadAllComponents()
        }
    }
    var components : [String] = Array(Set(CourseHandler.shared.getAllComponents().map { $0.name })).sorted { $0 < $1 }
}

extension ComponentPicker : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width, height: pickerView.rowSize(forComponent: component).height)
        let pickerView = LazyAPickerViewRow(frame: frame)
        pickerView.textLabel.text = self.component(for: row)
        return pickerView
    }
    
    func component( for row : Int ) -> String {
        return row == 0 ? "All Catagories" : components[row - 1]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        componentDelegate?.ComponentPicker(componentPicker: self, didSelect: self.component(for: row))
    }
}
