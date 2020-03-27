//
//  CreateAssignmentViewModel.swift
//  LazyA
//
//  Created by Michael Isasi on 4/22/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation
import UserNotifications

private enum TimeConstants {

    case hour, day, threeDays, week
    
    var timeValue : TimeInterval {
        switch self {
            case .hour: return 60 * 60
            case .day: return TimeConstants.hour.timeValue * 24
            case .threeDays: return TimeConstants.day.timeValue * 3
            case .week: return TimeConstants.day.timeValue * 7
        }
    }
}

struct CreateAssignmentViewModel {
    private var timeNotificationValues = [
        (time : TimeConstants.hour, isSet : true),
        (time : TimeConstants.day, isSet : true),
        (time : TimeConstants.threeDays, isSet : true),
        (time : TimeConstants.week, isSet : true)
    ]
    private let assignment : Assignment
    
    init() {
        self.assignment = Assignment()
    }
    
    func setName( name : String? ) {
        self.assignment.name = name ?? ""
    }
    
    func setWeight( weight : Int? ) {
        guard let weight = weight else {
            return
        }
        self.assignment.weight = weight
    }
    
    func setDesiredGrade( desiredGrade : Int? ) {
        guard let desiredGrade = desiredGrade else {
            return
        }
        self.assignment.desiredGrade = desiredGrade
    }
    
    func setDueDate( date : Date ) {
        self.assignment.dueDate = date
    }
    
    mutating func turnOffAllNotifications() {
        timeNotificationValues = [
            (time : TimeConstants.hour, isSet : false),
            (time : TimeConstants.day, isSet : false),
            (time : TimeConstants.threeDays, isSet : false),
            (time : TimeConstants.week, isSet : false)]
    }
    
    mutating func turnOnAllNotifications() {
        timeNotificationValues = [
            (time : TimeConstants.hour, isSet : true),
            (time : TimeConstants.day, isSet : true),
            (time : TimeConstants.threeDays, isSet : true),
            (time : TimeConstants.week, isSet : true)]
    }
    
    mutating func updateNotificationValue( for tag : Int) {
        timeNotificationValues[tag] =  (time : timeNotificationValues[tag].time, isSet : !timeNotificationValues[tag].isSet)
    }
    
    func setNotifications() {
        guard let date = self.assignment.dueDate else {
            return
        }

        let content = UNMutableNotificationContent()
        
        content.body = NSString.localizedUserNotificationString(forKey: "Due Date: \(self.assignment.desiredGrade)", arguments: nil)
        

        self.timeNotificationValues.filter{ $0.isSet }.forEach {
            content.title = NSString.localizedUserNotificationString(forKey: "\(self.assignment.name) is coming up!", arguments: nil)
            let dueDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day, .hour, .minute], from: date.addingTimeInterval(-$0.time.timeValue))
            print(dueDateComponents)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dueDateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "\(assignment.name)_\($0.time.timeValue))", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
}
