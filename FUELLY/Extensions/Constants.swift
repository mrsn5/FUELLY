//
//  Constants.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 04.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import FirebaseFirestore

let DEVICE_ID = UIDevice.current.identifierForVendor!.uuidString
let DB_USER = Firestore.firestore().collection("user")
