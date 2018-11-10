//
//  LazyAViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

@IBDesignable
class LazyAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        self.insertBlurryImage(of: UIImage(named: "forrest")! )
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LazyAViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func insertBlurryImage( of image : UIImage) {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
        blurView.alpha = 0.80
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.frame = imageView.bounds
        blurView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        self.view.addSubview(blurView)
        self.view.sendSubviewToBack(blurView)
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
