//
//  Colors.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//
import UIKit

enum Pallet : String {
    case primary, touch, accent, secondaryAccent, text
    
    var color : UIColor {
        return UIColor(named: self.rawValue.capitalizingFirstLetter())!
    }
}
