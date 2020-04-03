//
//  SearchCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import MapKit

class SimpleCell: UITableViewCell {
    
    static let reuseID = String(describing: SimpleCell.self)
    static let nib = UINib(nibName: String(describing: SimpleCell.self), bundle: nil)
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func configure(placemark: MKPlacemark) {
        self.title.text = placemark.name
        self.subtitle.text = placemark.title
    }
    
    func contentView(title: String, subtitle: String) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
}
