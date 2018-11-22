//
//  CoursePicker.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol CoursePickerDelegate : class {
    func CoursePicker( coursePicker : CoursePicker, didSelect course : Course?)
}

class CoursePicker: UIPickerView {
    
    weak var courseDelegate : CoursePickerDelegate?
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
    
    static let allCourses = CourseHandler.shared.getAll()
}

extension CoursePicker : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CoursePicker.allCourses.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width, height: pickerView.rowSize(forComponent: component).height)
        let pickerView = LazyAPickerViewRow(frame: frame)
        pickerView.textLabel.text = self.course(for: row)?.name ?? "All Classes"
        return pickerView
    }
    
    func course( for row : Int) -> Course? {
        return row == 0 ? nil : CourseHandler.shared.getAll()[row - 1]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        courseDelegate?.CoursePicker(coursePicker: self, didSelect: course(for: row))
    }
}
