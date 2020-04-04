//
//  Refill.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseFirestore

class Refill: SyncObject, Comparable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var price: Float = 0.0
    @objc dynamic var quantity: Float = 0.0
    @objc dynamic var station: Station? = nil
    @objc dynamic var fuelType: String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override var path: String {
        return "refills"
    }
    
    override var uid: String {
        return id
    }
    
    override func dictionary() -> [String:Any] {
        var dict: [String:Any] = [
            "id": id,
            "date": date,
            "price": price,
            "quantity": quantity,
            "fuelType": fuelType ?? "none"
        ]
        
        if let station = station {
            let stationRef: DocumentReference!
            stationRef = DB_USER.document(DEVICE_ID).collection(station.path).document(station.uid)
            print(stationRef)
            dict["station"] = stationRef
        }
        return dict
    }
    
    static func sortByDate (lhs: Refill, rhs: Refill) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func < (lhs: Refill, rhs: Refill) -> Bool {
        return sortByDate(lhs: lhs, rhs: rhs)
    }
}
