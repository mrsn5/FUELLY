//
//  StationCell.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

class StationCell: UICollectionViewCell {

    static let reuseID = String(describing: StationCell.self)
    static let nib = UINib(nibName: String(describing: StationCell.self), bundle: nil)

    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var visitsCounter: UILabel!
    @IBOutlet weak var lastMonthLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    override func layoutSubviews() {
        cardView.layer.cornerRadius = 10
    }
    
    func configure(_ station: Station) {
        supplierLabel.text = station.supplier
        addressLabel.text = station.address
        visitsCounter.text = "Visits: \(station.refills.count)"
        totalLabel.text = "Total: ₴ -/-"
        lastMonthLabel.text = "Last month: ₴ -/-"
        
        let stationRef = ThreadSafeReference(to: station)
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                guard let station = realm.resolve(stationRef) else { return }
                var total: Float = 0.0
                var lastMonth: Float = 0.0
                let lastMonthDate = Date().addingTimeInterval(-30 * 24 * 60 * 60)
                for r in station.refills {
                    total += r.price
                    if r.date > lastMonthDate {
                        lastMonth += r.price
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    self?.totalLabel.text = String(format: "Total: ₴ %.2f", total)
                    self?.lastMonthLabel.text = String(format: "Last month: ₴ %.2f", lastMonth)
                }
                
            }
        }
    }
    
    
}
