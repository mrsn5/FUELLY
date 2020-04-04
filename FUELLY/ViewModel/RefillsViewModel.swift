//
//  ReffilsViewModel.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

final class RefillsViewModel {
    
    static let shared = RefillsViewModel()
    let dataSource = RefillsDataSource()
    
    func fetch() {
        RefillsService.shared.fetch() { result in
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
    
    func save(_ refill: Refill) {
        RefillsService.shared.save(refill) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let refill):

                    let data = self.dataSource.value.data
                    if let row = data.firstIndex(of: refill) {
                        self.dataSource.value.stateChange = .delete(IndexPath(row: row, section: 0))
                        self.dataSource.value.stateChange = .insert(refill, (IndexPath(row: row, section: 0)))
                        self.dataSource.value.stateChange = .none
                    } else {
                        let row = data.insertBySortIndex(refill, isOrderedBefore: { $0 > $1 })
                        if (row < data.count || row == 0) {
                            self.dataSource.value.stateChange = .insert(refill, IndexPath(row: row, section: 0))
                            self.dataSource.value.stateChange = .none
                        }
                    }
                    break
                case .failure(let error):
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
    
    
    func delete(_ refill: Refill) {
        RefillsService.shared.delete(refill) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let refill):
                    let data = self.dataSource.value.data
                    if let row = data.firstIndex(of: refill) {
                        self.dataSource.value.stateChange = .delete(IndexPath(row: row, section: 0))
                        self.dataSource.value.stateChange = .none
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
