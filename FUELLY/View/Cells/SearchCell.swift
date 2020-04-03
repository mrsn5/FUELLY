//
//  SearchCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import MapKit

class SearchCell: UITableViewCell {
    
    static let reuseID = String(describing: SearchCell.self)
    static let nib = UINib(nibName: String(describing: SearchCell.self), bundle: nil)
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    
    func configure(placemark: MKPlacemark) {
        title.text = placemark.name
        self.address.text = placemark.title
    }
}
