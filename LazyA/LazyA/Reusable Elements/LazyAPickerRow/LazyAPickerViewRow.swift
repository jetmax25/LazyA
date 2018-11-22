//
//  LazyAPickerViewRow.swift
//  LazyA
//
//  Created by Michael Isasi on 11/20/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class LazyAPickerViewRow: UIView, NibFileOwnerLoadable {

    @IBOutlet weak var textLabel: LazyALabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        loadNibContent()
    }
}
