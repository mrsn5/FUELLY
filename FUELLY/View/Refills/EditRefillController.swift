//
//  AddRefillController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class RefillEditController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var fuelField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var stationButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var viewModel = RefillsViewModel.shared
    var stationsViewModel = StationsViewModel.shared
    
    var refill: Refill = Refill()
    var editingMode = false
    
    var selectedStation: DynamicValue<Station?> = DynamicValue(nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefill()
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(dismissGesture)
        
        selectedStation.addAndNotify(observer: self) { (station) in
            if station != nil {
                self.stationButton.setTitleColor(.black, for: .normal)
                self.stationButton.setTitle(station?.supplier,for: .normal)
            } else {
                self.stationButton.setTitleColor(.lightGray, for: .normal)
                self.stationButton.setTitle("Choose" ,for: .normal)
            }
        }
        
        stationsViewModel.dataSource.addAndNotify(observer: self) { (state) in
            switch state.stateChange {
            case let .insert(s, _):
                self.selectedStation.value = s
            default:
                break
            }
        }
    }
    
    func setupRefill() {
        if editingMode {
            deleteButton.isHidden = false
            titleLabel.text = "EDIT REFILL"
            fuelField.text = refill.fuelType
            quantityField.text = "\(refill.quantity)"
            priceField.text = "\(refill.price)"
            selectedStation.value = refill.station
        }
    }
    
    @IBAction func confirmed(_ sender: Any) {
        guard let station = selectedStation.value else { return }
        guard let priceText = priceField.text, let total = Float(priceText) else { return }
        guard let quantityText = quantityField.text, let quantity = Float(quantityText) else { return }
        
        Refill.update {
            refill.station = station
            refill.price = total
            refill.quantity = quantity
            refill.fuelType = fuelField.text
        }

        viewModel.save(refill)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stationTapped(_ sender: Any) {
        let stationPicker = StationPicker(nibName: "StationPicker", bundle: nil)
        stationPicker.selectedStation = self.selectedStation
        self.present(stationPicker, animated: true, completion: nil)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        viewModel.delete(refill)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        quantityField.resignFirstResponder()
        fuelField.resignFirstResponder()
        priceField.resignFirstResponder()
    }

}
