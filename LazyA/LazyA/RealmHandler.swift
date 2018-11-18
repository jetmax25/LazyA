//
//  RealmHandler.swift
//  LazyA
//
//  Created by Michael Isasi on 11/18/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import RealmSwift

class RealmHandler {
    static var shared : RealmHandler = RealmHandler()
    
    private init() {
    }
    
    private let realm = try! Realm()
    
    public func add<T>(object : T) where T : Object {
        try! realm.write {
            self.realm.add(object)
        }
    }

    public func getAll<T>() -> [T] where T : Object {
        return Array(self.realm.objects(T.self))
    }
    
    public func perform(_ action : ()->() ) {
        try! self.realm.write {
            action()
        }
    }
}
