//
//  AssignmentCalandar.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

public protocol AssignmentCalandarProtocol : AssignmentCalandarDataSource, AssignmentFilterDelegate {
    
    var assignmentFilterView: AssignmentFilterView! { get set }
    
    var assignmentsByDate : [Date? : [Assignment]] { get set }
    var sortedDates : [Date?] { get set }
    var dataSource : AssignmentCalandarDataSource? { get set }
}

extension AssignmentCalandarProtocol {
    public func updateAssignments() {
        let assignments = CourseHandler.shared.getAllAssignments().filter { filter?($0) ?? true }
        self.assignmentsByDate = assignments.seperatedByDate
        self.sortedDates = assignmentsByDate.keys.compactMap {$0}.sorted()
    }
    
    internal func updateDataSource() {
        guard let dataSource = self.dataSource else { return }
        if (dataSource === self) {
            self.assignmentFilterView?.isHidden = false
            self.assignmentFilterView?.delegate = self
        } else {
            self.assignmentFilterView?.isHidden = true
        }
    }
}

final class AssignmentMonthlyView: ReusableView, AssignmentCalandarProtocol {
    
    @IBOutlet weak var assignmentFilterView: AssignmentFilterView!
    @IBOutlet weak var calandarView: CalandarView!
    
    
    var filter : ((Assignment) -> Bool)?
    
    var assignmentsByDate : [Date? : [Assignment]] = [Date : [Assignment]]()
    var sortedDates = [Date?]()
    var dataSource : AssignmentCalandarDataSource?
    
    override func setUp() {
        if dataSource == nil { self.dataSource = self }
        super.setUp()
    }
    
}


extension AssignmentMonthlyView : AssignmentFilterDelegate {
    func assignmentFilterView(assignmentFilterView: AssignmentFilterView, didChangeFilter closure: (Assignment) -> Bool) {
        print("Did Change")
    }
}
