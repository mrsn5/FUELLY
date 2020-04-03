//
//  GenericDataSource.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

class GenericDataSource<T> : DynamicValue<State<T>> {
    init() {
        super.init(State<T>())
    }
}
