//
//  Refill.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Refill: Object, Comparable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var price: Float = 0.0
    @objc dynamic var quantity: Float = 0.0
    @objc dynamic var station: Station? = nil
    @objc dynamic var fuelType: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func sortByDate (lhs: Refill, rhs: Refill) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func < (lhs: Refill, rhs: Refill) -> Bool {
        return sortByDate(lhs: lhs, rhs: rhs)
    }
}
