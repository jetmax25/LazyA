//
//  CreateCourseTableViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol CreateCourseDelegate {
    var course : Course? {get}
    func updateCourse(grade : Int, name : String, courseCode : String?)
}



class CreateCourseTableViewController: LazyAViewController {
    
    
    
    
    @IBOutlet weak var doneButton: LazyAButton!
    @IBOutlet weak var tableView: UITableView!

    

    var viewModel : CreateCoursesViewModel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = CreateCoursesViewModel.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton.isEnabled = false
        tableView.register( cell : LazyATextDetailViewCell.self)
    }

    

    
    
    @IBAction func createNewCourse(_ sender: Any) {
        self.viewModel.selectedRow = nil
        self.performSegue(withIdentifier:  AppStrings.segues.editCourse.rawValue, sender: nil)
    }
    
    @IBAction func completeCourseCreation(_ sender: Any) {
        self.performSegue(withIdentifier: AppStrings.segues.createComponents.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.segues.editCourse.rawValue {
            let vc = segue.destination as! CreateCourseViewController
            vc.delegate = self
        }
        
        if segue.identifier == AppStrings.segues.createComponents.rawValue {
            viewModel.saveCourses()
        }
    }
}

extension CreateCourseTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numCourses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LazyATextDetailViewCell.name) as! LazyATextDetailViewCell
        cell.mainTextLabel?.text = viewModel.getCourseNameFor(row: indexPath.row)
        cell.subTextLabel?.text = viewModel.getCourseGradeFor(row: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow = indexPath.row
        self.performSegue(withIdentifier: AppStrings.segues.editCourse.rawValue, sender: nil)
    }
}

extension CreateCourseTableViewController : CreateCourseDelegate {
    var course: Course? {
        return viewModel.selectedCourse
    }
    
    func updateCourse(grade: Int, name: String, courseCode: String?) {
        self.viewModel.updateCourse(grade: grade, name: name, courseCode: courseCode)
        self.tableView.reloadData()
        self.doneButton.isEnabled = self.viewModel.numCourses > 0
    }
}
