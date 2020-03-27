//
//  LazyAButton.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import PickledSwift


final class LazyAButton: PickledButton {
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.3
        }
    }
    
    func setUp() {
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
    
    override final func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.titleLabel?.backgroundColor = UIColor.clear
        self.isSelected.toggle()
    }
}
