//
//  RefillsDataSource.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import UIKit


class RefillsDataSource : GenericDataSource<Refill>, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return value.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RefillCell.reuseID, for: indexPath) as? RefillCell else {
            fatalError("Wrong cell")
        }
        cell.configure(self.value.data[indexPath.row])
        return cell
    }
}
