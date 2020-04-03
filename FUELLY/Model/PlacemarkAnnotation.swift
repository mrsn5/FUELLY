//
//  PlacemarkAnnotation.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import MapKit

class PlacemarkAnnotation: MKPointAnnotation {
    
    let placemark: MKPlacemark
    
    init(placemark: MKPlacemark) {
        self.placemark = placemark
        super.init()
        coordinate = placemark.coordinate
        title = placemark.name
        subtitle = placemark.title
    }
}
