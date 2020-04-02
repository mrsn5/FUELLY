//
//  ReffilsViewModel.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

final class RefillsViewModel {
    
    weak var dataSource : GenericDataSource<Refill>?
    
    init(dataSource : GenericDataSource<Refill>?) {
        self.dataSource = dataSource
    }
    
    func fetchData() {
        RefillsService.shared.fetchRefills() { result in

            DispatchQueue.main.async {
                switch result {
                case .success(let refills):
                    self.dataSource?.value.editingStyle = .reload(refills)
                    break
                case .failure(let error):
                    print("Parser error \(error)")
                    break
                }
            }
        }
    }
}
