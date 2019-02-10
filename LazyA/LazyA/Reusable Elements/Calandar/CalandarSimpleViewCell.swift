//
//  CalandarSimpleViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 12/2/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class CalandarSimpleViewCell: UICollectionViewCell, EasilyRegisterableCell {
 
    var numItems : Int = 0 {
        didSet {
            if numItems == 0 {
                self.numItemsLabel.text = nil
            } else {
                self.numItemsLabel.text = String(numItems)
            }
        }
    }
    var simpleDate : SimpleDate? {
        didSet {
            guard let simpleDate = simpleDate else { return }
            self.dateLabel.text = String(simpleDate.day)
            self.alpha = simpleDate.isInPast ? 0.8 : 1.0
            
            if simpleDate.isToday {
                self.contentView.layer.borderColor = UIColor.black.cgColor
                self.contentView.layer.borderWidth = 5
            } else {
                self.contentView.layer.borderWidth = 0
            }
        }
    }
    static var nib : UINib {
        return UINib(nibName: "CalandarSimpleViewCell", bundle: nil)
    }
    
    
    @IBOutlet weak var dateLabel: LazyALabel!
    @IBOutlet weak var numItemsLabel: UILabel!
}
