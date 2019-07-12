//
//  LazyAButton.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit


class LazyAButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.3
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        
        self.layer.cornerRadius = 10
        self.setTitleShadowColor(UIColor.black, for: .normal)
        self.titleLabel?.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.setTitleColor(UIColor.Pallet.Text, for: .normal)
        self.backgroundColor = UIColor.Pallet.Touch
        
        //self.titleLabel?.font = self.titleLabel?.font.withSize(24)
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .center
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}
