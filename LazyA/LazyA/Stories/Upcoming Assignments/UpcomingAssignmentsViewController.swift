//
//  UpcomingAssignmentsViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class UpcomingAssignmentsViewController: LazyAViewController {
    @IBOutlet weak var filterView: AssignmentFilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterView.translatesAutoresizingMaskIntoConstraints = false
    }
}
