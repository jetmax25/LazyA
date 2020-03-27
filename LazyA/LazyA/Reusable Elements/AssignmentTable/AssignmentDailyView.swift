//
//  AssignmentTableView.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

public protocol AssignmentCalandarDataSource : AnyObject {
    var filter : ((Assignment) -> Bool)? { get }
}

import UIKit
import PickledSwift

final class AssignmentDailyView: ReusableView, AssignmentCalandarProtocol {
    @IBOutlet weak var assignmentFilterView: AssignmentFilterView!
    @IBOutlet weak var assignmentTableView: UITableView!
    
    var filter : ((Assignment) -> Bool)?
    
    var assignmentsByDate : [Date? : [Assignment]] = [Date : [Assignment]]()
    var sortedDates = [Date?]()
    
    var dataSource : AssignmentCalandarDataSource? {
        //If the dataSource is itself then it is also the delegate, otherwise the filterview should be hidden
        didSet {
            self.updateDataSource()
        }
    }
    
    override func setUp() {
        if dataSource == nil { self.dataSource = self }
        super.setUp()
    }
}

extension AssignmentDailyView : AssignmentFilterDelegate {
    func assignmentFilterView(assignmentFilterView: AssignmentFilterView, didChangeFilter closure: (Assignment) -> Bool) {
        self.updateAssignments()
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

