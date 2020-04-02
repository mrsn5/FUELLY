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

class Station: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var adress: String = ""
    @objc dynamic var supplier: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}


class StationAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D

    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
