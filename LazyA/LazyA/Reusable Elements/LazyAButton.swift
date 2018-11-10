//
//  LazyAButton.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

@IBDesignable
class LazyAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(Pallet.text.color, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = Pallet.touch.color
        self.setTitleShadowColor(UIColor.black, for: .normal)
        self.titleLabel?.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}
