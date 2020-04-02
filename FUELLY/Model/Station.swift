//
//  Station.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Station: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var adress: String = ""
    @objc dynamic var supplier: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
