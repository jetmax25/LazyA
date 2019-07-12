//
//  SimpleDate.swift
//  LazyA
//
//  Created by Michael Isasi on 2/9/19.
//  Copyright © 2019 Jetmax25. All rights reserved.
//

import Foundation


/// A date in terms of a day, month and year
struct SimpleDate {
    var month : Month
    var year : Int
    var day : Int {
        didSet {
            let range = self.month.days(for: self.year)
            if self.day > range {
                self.day = range
            } else if self.day == 0 {
                self.day = 1
            }
        }
    }
    
    init ( day : Int, month : Month, year : Int ) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    init( date : Date ) {
        let calendar = Calendar.current
        self.day = calendar.component(.day, from: date)
        self.year = calendar.component(.year, from: date)
        self.month = date.month
    }
}


extension SimpleDate : Comparable, Hashable {
    static func < (lhs: SimpleDate, rhs: SimpleDate) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        
        if lhs.month != rhs.month {
            return lhs.month.rawValue < rhs.month.rawValue
        }
        
        return lhs.day < rhs.day
    }
    
    var daysInMonth : Int {
        return self.month.days(for: self.year)
    }
    
    static var today : SimpleDate {
        return SimpleDate.init(date: Date())
    }
    
    func get( direction : DirectionType, component : Calendar.Component ) -> SimpleDate {
        var day : Int = self.day
        var month : Month = self.month
        var year : Int = self.year
        
        switch component {
        case .day: day += direction.rawValue
        case .year: year += direction.rawValue
        case .month:
            if direction == .next {
                month = self.month.next
                if month == .january {
                    year += 1
                }
            } else {
                month = self.month.previous
                if month == .december {
                    year -= 1
                }
            }
        default: fatalError()
        }
        
        return SimpleDate(day: day, month: month, year: year)
    }
    
    var isToday : Bool {
        return self == SimpleDate.today
    }
    
    var isInPast : Bool {
        return self < SimpleDate.today
    }
    
    var date : Date {
        var dateComponents = DateComponents()
        dateComponents.year = self.year
        dateComponents.month = self.month.rawValue
        dateComponents.day = self.day
        return Calendar.current.date(from: dateComponents)!
    }
}

public enum DirectionType : Int {
   case next = 1, previous = -1
}
