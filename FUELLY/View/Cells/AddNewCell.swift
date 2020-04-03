//
//  AddNewCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class AddNewCell: UITableViewCell {

    static let reuseID = String(describing: AddNewCell.self)
    static let nib = UINib(nibName: String(describing: AddNewCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
}
