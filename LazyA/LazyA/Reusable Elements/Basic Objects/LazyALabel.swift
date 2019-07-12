//
//  LazyALabel.swift
//  LazyA
//
//  Created by Michael Isasi on 11/16/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit


class LazyALabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.shadowColor = UIColor.black
        self.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.textColor = UIColor.Pallet.Text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}
