//
//  LazyASearchBar.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import PickledSwift

class LazyASearchBar: UISearchBar {

    private var textField : UITextField? {
        return self.value(forKey: "searchField") as? UITextField
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
        self.textField?.textColor = UIColor.Pallet.text.color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
}
