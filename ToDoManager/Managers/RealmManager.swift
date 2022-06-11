//
//  RealmManager.swift
//  ToDoManager
//
//  Created by Andrew Moroz on 11.06.22.
//
/*
import Foundation
import RealmSwift

final class RealmManager {
    
    private static let realm = try! Realm()
    
    class func read<T: Object>(type: T.Type) -> [T] {
        return Array(realm.objects(type.self))
    }
    
    class func add<T: Object>(object: T) {
        try? realm.write({
            realm.add(object)
        })
    }
    
    class func remove<T: Object>(object: T) {
        try? realm.write({
            realm.delete(object)
        })
    }
    
    class func startTransaction() {
        realm.beginWrite()
    }
    
    class func closeTransaction() {
        try? realm.commitWrite()
    }
}

 */
