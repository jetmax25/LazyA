//
//  Colors.swift
//  LazyA
//
//  Created by Michael Isasi on 11/10/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//
import UIKit


extension UIColor {
    
    //hext init
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    struct Pallet {
         static var Primary : UIColor{
            #if TARGET_INTERFACE_BUILDER
            return UIColor(red: 0.459, green: 0.867, blue: 0.867, alpha: 1.0)// An IB-only stand-in color.
            #else
            return UIColor(named: "Primary")! // The run-time color we really want.
            #endif
        }
        
        static var Touch : UIColor{
            #if TARGET_INTERFACE_BUILDER
            return UIColor(red: 0.0, green: 0.263, blue: 0.275, alpha: 1.0) // An IB-only stand-in color.
            #else
            return UIColor(named: "Touch")! // The run-time color we really want.
            #endif
        }
        
        static var Accent : UIColor{
            #if TARGET_INTERFACE_BUILDER
            return UIColor(red: 0.314, green: 0.533, blue: 0.569, alpha: 1.0)// An IB-only stand-in color.
            #else
            return UIColor(named: "Accent")! // The run-time color we really want.
            #endif
        }
        
        static var SecondaryAccent : UIColor{
            #if TARGET_INTERFACE_BUILDER
            return UIColor(red: 0.09, green: 0.165, blue: 0.277, alpha: 1.0) // An IB-only stand-in color.
            #else
            return UIColor(named: "SecondaryAccent")! // The run-time color we really want.
            #endif
        }
        
        static var Text : UIColor{
            #if TARGET_INTERFACE_BUILDER
            return UIColor(red: 0.035, green: 0.737, blue: 0.541, alpha: 1.0) // An IB-only stand-in color.
            #else
            return UIColor(named: "Text")! // The run-time color we really want.
            #endif
        }
    }
}
