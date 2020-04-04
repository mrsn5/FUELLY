//
//  Realm+.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 04.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import RealmSwift

extension Object {
    static func update(updateHandler: () -> Void) {
        let realm = try! Realm()
        try! realm.write {
            updateHandler()
        }
    }
}

protocol RealmToDictionary {
    func dictionary() -> [String:Any]
}

class SyncObject: Object, RealmToDictionary, Identifiable {
    
    
    @objc dynamic var isSync: Bool = false
    
    var uid: String {
        return UUID.init().uuidString
    }
    
    var path: String {
        return "object"
    }
    
    
    func dictionary() -> [String : Any] {
        return [:]
    }
    
    override static func ignoredProperties() -> [String] {
        return ["path", "uid"]
    }
    
}

