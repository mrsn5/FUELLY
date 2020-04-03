//
//  StationsViewModel.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

final class StationsViewModel {
    
    static let shared = StationsViewModel()
    let dataSource = StationsDataSource()
    
    func fetch() {
        StationsService.shared.fetch() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let refills):
                    self.dataSource.value.stateChange = .reload(refills)
                    break
                case .failure(let error):
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
    
    func save(_ station: Station) {
        StationsService.shared.save(station) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let refill):
                    let data = self.dataSource.value.data
                    let row = data.insertBySortIndex(station, isOrderedBefore: { $0 > $1 })
                    if (row < data.count || row == 0) {
                        self.dataSource.value.stateChange = .insert(refill, IndexPath(row: row, section: 0))
                    }
                    break
                case .failure(let error):
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
    
    
}
