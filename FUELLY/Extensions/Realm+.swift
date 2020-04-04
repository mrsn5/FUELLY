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
