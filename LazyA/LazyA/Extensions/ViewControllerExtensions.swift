//
//  ViewControllerExtensions.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

extension UIViewController {
        func messageAlert( title : String = "", message : String = "" ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
}
