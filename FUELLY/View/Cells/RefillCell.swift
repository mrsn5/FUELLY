//
//  RefillCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class RefillCell: UICollectionViewCell {

    static let reuseID = String(describing: RefillCell.self)
    static let nib = UINib(nibName: String(describing: RefillCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
