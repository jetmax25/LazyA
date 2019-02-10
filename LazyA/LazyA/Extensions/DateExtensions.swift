//
//  DateExtensions.swift
//  LazyA
//
//  Created by Michael Isasi on 12/1/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//
import Foundation

extension Date {
    var simpleDateString : String {
        return self.toString(format: "MM/dd")
    }
    
    var dateWithTimeString : String {
        return self.toString(format: "MM/dd HH:mm a")
    }
    
    func toString( format : String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var dayOfTheWeek : Int {
        return Calendar.current.component(.weekday, from: self)
    }
}
