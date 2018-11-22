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
    
    public func delete<T>(object : T) where T : Object {
        try! realm.write {
            self.realm.delete(object)
        }
    }

    public func getAll<T>() -> [T] where T : Object {
        return Array(self.realm.objects(T.self))
    }
    
    public func get<T>( where filter : NSPredicate) -> T? where T : Object {
        return self.realm.objects(T.self).filter(filter).first
    }
    
    public func perform(_ action : ()->() ) {
        try! self.realm.write {
            action()
        }
    }
    
    public func get<T>(_ key : String) -> T? where T : Object {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    public func deleteAll() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}
