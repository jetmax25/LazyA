//
//  AssignmentTableView.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

protocol AssignmentCalandarDataSource : AnyObject {
    var filter : ((Assignment) -> Bool)? { get set }
    var assignmentsByDate : [Date? : [Assignment]] { get set }
    var sortedDates : [Date?] { get set }
    func updateAssignments()
}

extension AssignmentCalandarDataSource {
    func updateAssignments() {
        let assignments = CourseHandler.shared.getAllAssignments().filter { filter?($0) ?? true }
        self.assignmentsByDate = assignments.seperatedByDate
        self.sortedDates = assignmentsByDate.keys.compactMap {$0}.sorted()
    }
}

import UIKit

final class AssignmentDailyView: ReusableView, AssignmentCalandarDataSource {
    @IBOutlet weak var assignmentFilterView: AssigmentFilterView!
    @IBOutlet weak var assignmentTableView: UITableView!
    
    var filter : ((Assignment) -> Bool)?
    var assignmentsByDate : [Date? : [Assignment]] = [Date : [Assignment]]()
    var sortedDates = [Date?]()
    
    var dataSource : AssignmentCalandarDataSource?
    
    override func setUp() {
        if dataSource == nil { self.dataSource = self }
        super.setUp()
        self.assignmentFilterView.delegate = self
    }
}


extension AssignmentDailyView : AssignmentFilterDelegate {
    func assignmentFilterView(assignmentFilterView: AssigmentFilterView, didChangeFilter closure: (Assignment) -> Bool) {
        self.dataSource?.updateAssignments()
        self.assignmentTableView.reloadData()
    }
}

extension AssignmentDailyView : UITableViewDelegate, UITableViewDataSource {
    func assignments( in section : Int) -> [Assignment] {
        return assignmentsByDate[sortedDates[section]] ?? [Assignment]()
    }
    
    func assignment( for row :Int, in section : Int) -> Assignment? {
        return assignments(in: section)[row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.assignmentsByDate.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let date = self.sortedDates[section] {
            return date.simpleDateString
        }
        return "No Due Date"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments(in: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

