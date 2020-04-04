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
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceInfo: UILabel!
    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationAddress: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    let cornerRadius: CGFloat = 10.0
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = cornerRadius
    }
    
    func configure(_ refill: Refill) {
        totalLabel.text = String(format: "₴ %.2f", refill.price)
        priceInfo.text = String(format: "₴ %.2f × %.2f", refill.price / refill.quantity, refill.quantity)
        
        stationName.text = refill.station?.supplier
        stationAddress.text = refill.station?.address
        
        
        timeLabel.text = DateFormatter.standart(date: refill.date)
    }
    
}
