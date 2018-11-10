//
//  UserInfo.swift
//  LazyA
//
//  Created by Michael Isasi on 4/5/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import Foundation


class UserInfo {
    static let shared = UserInfo.init()
    
    private init(){
        self.courses = [Course]()
    }
    
    var courses : [Course]
}
