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

extension Realm {
    func writeAsync<T : ThreadConfined>(obj: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }, block: @escaping ((Realm, T?) -> Void)) {
        let wrappedObj = ThreadSafeReference(to: obj)
        let config = self.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    let obj = realm.resolve(wrappedObj)

                    try realm.write {
                        block(realm, obj)
                    }
                }
                catch {
                    errorHandler(error)
                }
            }
        }
    }
}

protocol RealmToDictionary {
    func dictionary() -> [String:Any]
}


class SyncObject: Object, RealmToDictionary {
    
    
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

