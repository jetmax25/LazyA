//
//  CreateAssignmentViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/22/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import PickledSwift

class CreateAssignmentViewController: LazyAViewController {

    @IBOutlet weak var nameTextField: PickledTextField!
    @IBOutlet weak var weightTextField: PickledTextField!
    @IBOutlet weak var desiredGradeTextField: PickledTextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var reminderSegueControl: LazyASegmentedControl!
    
    @IBOutlet weak var hourSwitch: PickledSwitch!
    @IBOutlet weak var daySwitch: PickledSwitch!
    @IBOutlet weak var threeDaySwitch: PickledSwitch!
    @IBOutlet weak var weekSwitch: PickledSwitch!
    
    var viewModel : CreateAssignmentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weightTextField.keyboardType = .numberPad
        self.desiredGradeTextField.keyboardType = .numberPad
        self.viewModel = CreateAssignmentViewModel.init()
    }
    
    @IBAction func updateName(_ sender: Any) {
        self.viewModel.setName(name: self.nameTextField.text)
    }
    
    @IBAction func updateWeight(_ sender: Any) {
        self.viewModel.setWeight(weight: Int(self.weightTextField.text ?? ""))
    }
    
    @IBAction func updateDesiredGrade(_ sender: Any) {
        self.viewModel.setDesiredGrade(desiredGrade: Int(self.desiredGradeTextField.text ?? ""))
    }
    
    var allSwitches : [UISwitch] {
        return [self.hourSwitch, self.daySwitch, self.threeDaySwitch, self.weekSwitch]
    }
    
    @IBAction func chooseDate(_ sender: Any) {
        self.viewModel.setDueDate(date: self.datePicker.date)
    }
    
    @IBAction func setReminder(_ sender: UISwitch) {
        self.reminderSegueControl.selectedSegmentIndex = 1
        self.viewModel.updateNotificationValue(for: sender.tag)
    }
    
    @IBAction func setAllReminders(_ sender: Any) {
        switch self.reminderSegueControl.selectedSegmentIndex {
        case 0:
            allSwitches.forEach { $0.isOn = true }
            viewModel.turnOnAllNotifications()
        case 2:
            allSwitches.forEach { $0.isOn = false }
            viewModel.turnOffAllNotifications()
            
        default: return
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        self.viewModel.setName(name: self.nameTextField.text)
        self.viewModel.setWeight(weight: Int(self.weightTextField.text ?? ""))
        self.viewModel.setDesiredGrade(desiredGrade: Int(self.desiredGradeTextField.text ?? ""))
        self.viewModel.setNotifications()
    }
}
