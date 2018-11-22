//
//  CourseGlanceCollectionViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 11/19/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class CourseGlanceCollectionViewCell: UICollectionViewCell, EasilyRegisterableCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var goalLabel: LazyALabel!
    @IBOutlet weak var currentLabel: LazyALabel!
    @IBOutlet weak var courseNameLabel: LazyALabel!
    @IBOutlet weak var goalValueLabel: LazyALabel!
    @IBOutlet weak var currentGradeLabel: LazyALabel!
    
    weak var course : Course? {
        didSet {
            if let _course = course {
                self.goalValueLabel.text    =   String(_course.desiredGrade)
                self.currentGradeLabel.text =   _course.currentGrade == 0 ? "N/A" : String(_course.currentGrade)
                self.courseNameLabel.text   =   String(_course.name)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.containerView.layer.shadowRadius = 7
        self.containerView.layer.shadowOpacity = 1
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.containerView.layer.cornerRadius = self.containerView.bounds.width / 2
    }
}
