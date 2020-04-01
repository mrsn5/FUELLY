//
//  StationCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class StationCell: UICollectionViewCell {

    static let reuseID = String(describing: StationCell.self)
    static let nib = UINib(nibName: String(describing: StationCell.self), bundle: nil)

    @IBOutlet weak var cardView: UIView!
    
    override func layoutSubviews() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
    }
}
