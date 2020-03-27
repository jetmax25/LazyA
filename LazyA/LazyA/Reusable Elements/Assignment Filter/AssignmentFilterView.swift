//
//  AssigmentFilterView.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import PickledSwift


public protocol AssignmentFilterDelegate : AnyObject {
    func assignmentFilterView( assignmentFilterView : AssignmentFilterView, didChangeFilter closure : (Assignment) -> Bool )
}

public final class AssignmentFilterView: ReusableView {
    
    override public func setUp() {
        super.setUp()
    }
    
    var assignmentFilter : ((Assignment) -> Bool) {
        return { assignment in
            
            let searchFunction = {
                return self.searchText.isEmpty || assignment.name.contains(self.searchText)
            }
        
            let courseFunction = {
                return self.course == nil || self.course!.assignments.contains(assignment)
            }
        
            let componentFunction = {
                return self.componentString == nil || CourseHandler.shared.getAllComponents().filter { $0.name == self.componentString!}.contains { $0.assigments.contains(assignment)}
            }
        
            let completionFunction = {
                return self.completionStatus == nil || assignment.completionStatus == self.completionStatus
            }

        
            return searchFunction() && completionFunction() && componentFunction() && courseFunction()
        }
    }
    
    var searchText : String = "" {
        didSet {
            delegate?.assignmentFilterView(assignmentFilterView: self, didChangeFilter: assignmentFilter)
        }
    }
    
    
    var course : Course? = nil {
        didSet {
            self.componentPicker.course = course
        }
    }
    
    var componentString : String? = nil {
        didSet {
            delegate?.assignmentFilterView(assignmentFilterView: self, didChangeFilter: assignmentFilter)
        }
    }
    
    var completionStatus : CompletionStatus? {
        didSet {
            delegate?.assignmentFilterView(assignmentFilterView: self, didChangeFilter: assignmentFilter)
        }
    }
    @IBAction func collapseToggle(_ sender: Any) {
        self.fliterStack.isHidden.toggle()
    }
    @IBOutlet weak var fliterStack: UIStackView!
    
    weak var delegate : AssignmentFilterDelegate?
    
    @IBOutlet weak var completionSegmentedIndex: CompletionSegmentedControl!
    @IBOutlet weak var coursePicker: CoursePicker!
    @IBOutlet weak var componentPicker: ComponentPicker!
    @IBOutlet weak var assignmentSearchBar: UISearchBar!
}

extension AssignmentFilterView : CoursePickerDelegate {
    func CoursePicker(coursePicker: CoursePicker, didSelect course: Course?) {
        self.course = course
    }
}

extension AssignmentFilterView : ComponentPickerDelegate {
    func ComponentPicker(componentPicker: ComponentPicker, didSelect component: String) {
        self.componentString = component
    }
}

extension AssignmentFilterView : CompletionSegmentedControlDelegate {
    func completionSegmentedControl(completionSegmentedControl: CompletionSegmentedControl, didSelectCompletionStatus status: CompletionStatus?) {
        self.completionStatus = status
    }
}

extension AssignmentFilterView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
