//
//  LazyAViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import PickledSwift

open class LazyAViewController: PickledViewController {

    var doesUseBlurryImage : Bool {
        return true
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        if doesUseBlurryImage {
            self.insertBlurryImage(of: UIImage(named: "chalkboard")! )
        }
    }
    
    func insertBlurryImage( of image : UIImage?) {
        OperationQueue.main.addOperation { [weak self] in
            guard let image = image, let self = self else { return }
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
            blurView.alpha = 0.70
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.frame = imageView.bounds
            blurView.backgroundColor = UIColor.Pallet.background.color.withAlphaComponent(0.50)
            self.view.addSubview(blurView)
            self.view.sendSubviewToBack(blurView)
            self.view.addSubview(imageView)
            self.view.sendSubviewToBack(imageView)
        }
    }
}
