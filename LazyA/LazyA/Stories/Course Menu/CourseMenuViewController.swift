//
//  CourseMenuViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class CourseMenuViewController: LazyAViewController {

    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    let viewModel = CourseMenuViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseCollectionView.register(cell: CourseGlanceCollectionViewCell.self)
    }
}

extension CourseMenuViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numCourses
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseGlanceCollectionViewCell.name, for: indexPath) as! CourseGlanceCollectionViewCell
        cell.course = viewModel.course(for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 5
        return CGSize(width: width, height: width)
    }
}
