//
//  UpcomingAssignmentsViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class UpcomingAssignmentsViewController: UIViewController {

    @IBOutlet weak var coursePicker: CoursePicker!
    @IBOutlet weak var componentPicker: ComponentPicker!
    
    var course : Course? {
        didSet {
            componentPicker.course = course
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coursePicker.courseDelegate = self
        self.componentPicker.componentDelegate = self
        // Do any additional setup after loading the view.
    }
}

extension UpcomingAssignmentsViewController : CoursePickerDelegate {
    func CoursePicker(coursePicker: CoursePicker, didSelect course: Course?) {
        self.course = course
    }
}

extension UpcomingAssignmentsViewController : ComponentPickerDelegate {
    func ComponentPicker(componentPicker: ComponentPicker, didSelect component: String) {
        print(component)
    }
}
