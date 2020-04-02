//
//  Refill.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Refill: Object {
    @objc dynamic var id = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var price: Float = 0.0
    @objc dynamic var quantity: Float = 0.0
    @objc dynamic var station: Station? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
