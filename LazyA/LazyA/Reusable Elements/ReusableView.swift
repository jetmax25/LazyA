//
//  ReusableView.swift
//  LazyA
//
//  Created by Michael Isasi on 11/30/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit


/// Easy setup for a view to be created from a nib of hte same name
open class ReusableView: UIView {
    public static var nibName: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    internal func setUp() {
        loadNibContent()
    }
    
    public var nib: UINib {
        return UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }
    
    func instantiateFromNib() -> UIView? {
        let view = self.nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    func loadNibContent() {
        guard let view = instantiateFromNib() else {
            fatalError("Failed to instantiate nib \(self.nib)")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let views = ["view": view]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        addConstraints(verticalConstraints + horizontalConstraints)
    }
}
