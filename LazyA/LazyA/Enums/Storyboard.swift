//
//  Storyboard.swift
//  LazyA
//
//  Created by Michael Isasi on 11/21/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

enum Storyboard : String {
    case UpcomingAssignments, CourseMenu, HomeMenu, CreateCourse, Main, TabContainer
    
    func launch() {
        guard let storyboard = storyboard else {
            return
        }
        UIApplication.shared.delegate?.window??.rootViewController = storyboard
    }
    
    private var storyboard : UIViewController? {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
        return storyboard.instantiateInitialViewController()

    }
}
