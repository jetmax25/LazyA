//
//  DailyAssignmentCalandarViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class DailyAssignmentCalandarViewController: UIViewController {

    @IBOutlet var dailyAssignmentView: AssignmentDailyView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dailyAssignmentView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension DailyAssignmentCalandarViewController: AssignmentCalandarDataSource {
    var filter: ((Assignment) -> Bool)? {
        return { _ in
            return true
        }
    }
}
