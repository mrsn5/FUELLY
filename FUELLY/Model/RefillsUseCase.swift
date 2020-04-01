//
//  RefillsUseCaseType.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import Combine

protocol RefillsUseCaseType {
    func loadAll() -> AnyPublisher<Result<[Reffil], Error>, Never>
}



