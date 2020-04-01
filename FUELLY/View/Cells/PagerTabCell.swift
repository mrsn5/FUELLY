//
//  PagerTabCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class PagerTabCell: UICollectionViewCell {
    
    
    static let reuseID = String(describing: PagerTabCell.self)
    static let nib = UINib(nibName: String(describing: PagerTabCell.self), bundle: nil)
    
    @IBOutlet weak var iconImage: UIImageView!
}
