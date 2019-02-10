//
//  AssigmentFilterView.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit



protocol AssignmentFilterDelegate : AnyObject {
    func assignmentFilterView( assignmentFilterView : AssigmentFilterView, didChangeFilter closure : (Assignment) -> Bool )
}

@IBDesignable
final class AssigmentFilterView: ReusableView {
    
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
    
    weak var delegate : AssignmentFilterDelegate?
    
    @IBOutlet weak var completionSegmentedIndex: CompletionSegmentedControl!
    @IBOutlet weak var coursePicker: CoursePicker!
    @IBOutlet weak var componentPicker: ComponentPicker!
    @IBOutlet weak var assignmentSearchBar: UISearchBar!
}

extension AssigmentFilterView : CoursePickerDelegate {
    func CoursePicker(coursePicker: CoursePicker, didSelect course: Course?) {
        self.course = course
    }
}

extension AssigmentFilterView : ComponentPickerDelegate {
    func ComponentPicker(componentPicker: ComponentPicker, didSelect component: String) {
        self.componentString = component
    }
}

extension AssigmentFilterView : CompletionSegmentedControlDelegate {
    func completionSegmentedControl(completionSegmentedControl: CompletionSegmentedControl, didSelectCompletionStatus status: CompletionStatus?) {
        self.completionStatus = status
    }
}

extension AssigmentFilterView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
