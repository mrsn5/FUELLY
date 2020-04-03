//
//  Station.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Station: Object, Comparable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var address: String = ""
    @objc dynamic var supplier: String = ""
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var lat: Double = 0.0
    let refills = LinkingObjects(fromType: Refill.self, property: "station")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init() {}
    
    init(placemark: MKPlacemark) {
        address = placemark.title ?? ""
        supplier = placemark.name ?? ""
        lon = placemark.coordinate.longitude
        lat = placemark.coordinate.latitude
        
    }
    
    static func sortByDate (lhs: Station, rhs: Station) -> Bool {
        return lhs.supplier < rhs.supplier
    }
    
    static func < (lhs: Station, rhs: Station) -> Bool {
        return sortByDate(lhs: lhs, rhs: rhs)
    }
}
