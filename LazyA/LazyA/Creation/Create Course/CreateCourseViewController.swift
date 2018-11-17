//
//  CreateCourseViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 3/12/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit



class CreateCourseViewController: LazyAViewController {

    @IBOutlet weak var courseNameTxtFld: UITextField!
    @IBOutlet weak var courseCodeTxtFld: UITextField!
    @IBOutlet weak var gradeWantedLabel: UILabel!
    @IBOutlet weak var gradeSlider: UISlider!
    
    var delegate : CreateCourseDelegate!
    
    override var doesUseBlurryImage: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.courseNameTxtFld.becomeFirstResponder()
        
        if let course = delegate.course {
            courseNameTxtFld.text = course.name
            courseCodeTxtFld.text = course.courseCode
            gradeSlider.value = Float(course.desiredGrade)
            self.gradeWantedLabel.text = "Goal: \(gradeSlider.value)"
        }
    }
    
    @IBAction func gradeWantedChanged(_ sender: Any) {
        self.gradeSlider.value = self.gradeSlider.value.rounded()
        self.gradeWantedLabel.text = "Goal: \(gradeSlider.value)"
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        if courseNameTxtFld.text?.isEmpty ?? true {
            self.messageAlert(title: "Missing Field", message: "Missing Course Name")
            return
        }
        
        delegate.updateCourse(grade: Int(gradeSlider.value), name: courseNameTxtFld.text!, courseCode: courseCodeTxtFld.text)
        self.dismiss(animated: true, completion: nil)
    }
}


