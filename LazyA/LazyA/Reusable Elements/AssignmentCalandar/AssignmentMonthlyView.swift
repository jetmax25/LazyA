//
//  AssignmentCalandar.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit


final class AssignmentMonthlyView: ReusableView, AssignmentCalandarDataSource {
    @IBOutlet weak var filterView: AssignmentFilterView!
    @IBOutlet weak var assignmentCollectionView: UICollectionView!
    
    var filter : ((Assignment) -> Bool)?
    var assignmentsByDate : [Date? : [Assignment]] = [Date : [Assignment]]()
    var sortedDates = [Date?]()
    
    var dataSource : AssignmentCalandarDataSource?
    
    override func setUp() {
        if dataSource == nil { self.dataSource = self }
        super.setUp()
        self.filterView.delegate = self
    }
    
}

extension AssignmentMonthlyView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}


extension AssignmentMonthlyView : AssignmentFilterDelegate {
    func assignmentFilterView(assignmentFilterView: AssignmentFilterView, didChangeFilter closure: (Assignment) -> Bool) {
        self.dataSource?.updateAssignments()
        self.assignmentCollectionView.reloadData()
    }
}
