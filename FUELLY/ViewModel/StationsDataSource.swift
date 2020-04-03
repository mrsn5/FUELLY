//
//  StationsDataSource.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//


import Foundation
import UIKit


class StationsDataSource : GenericDataSource<Station>, UICollectionViewDataSource, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return value.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationCell.reuseID, for: indexPath) as? StationCell else {
            fatalError("Wrong cell")
        }
        cell.configure(self.value.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddNewCell.reuseID, for: indexPath) as? AddNewCell else {
                fatalError("Wrong cell")
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCell.reuseID, for: indexPath) as? SimpleCell else {
                fatalError("Wrong cell")
            }
            let data = self.value.data[indexPath.row-1]
            cell.contentView(title: data.supplier, subtitle: data.address)
            return cell
        }
    }
}
