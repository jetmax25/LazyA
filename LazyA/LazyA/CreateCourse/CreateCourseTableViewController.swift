//
//  CreateCourseTableViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

protocol createCourseDelegate {
    var course : Models.Course? {get}
    func updateCourse(grade : Int, name : String, courseCode : String?)
}


class CreateCourseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, createCourseDelegate{
    
    var course: Models.Course? {
        return viewModel.selectedCourse
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var editCourseSegueName : String {
        return "EditCourse"
    }
    
    var cellName : String {
        return "StandardCell"
    }
    
    func updateCourse(grade: Int, name: String, courseCode: String?) {
        self.viewModel.updateCourse(grade: grade, name: name, courseCode: courseCode)
        self.tableView.reloadData()
    }

    var viewModel : CreateCoursesViewModel!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = CreateCoursesViewModel.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.numCourses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName)!
        cell.textLabel?.text = viewModel.getCourseNameFor(row: indexPath.row)
        cell.detailTextLabel?.text = viewModel.getCourseGradeFor(row: indexPath.row)
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedRow = indexPath.row
        self.performSegue(withIdentifier: editCourseSegueName, sender: nil)
    }
    
    @IBAction func createNewCourse(_ sender: Any) {
        self.viewModel.selectedRow = nil
        self.performSegue(withIdentifier: editCourseSegueName, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CreateCourseViewController
        vc.delegate = self
    }
    
}
