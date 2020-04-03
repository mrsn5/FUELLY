//
//  StationCreationView.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class StationCreationView: UIViewController {

    var station = Station()
    let viewModel = StationsViewModel.shared
    var dismissCallback: (() -> Void)?
    
    @IBOutlet weak var supplierField: UITextField!

    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        supplierField.text = station.supplier
        addressField.text = station.address
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(dismissGesture)
    }

    @IBAction func save(_ sender: Any) {
        guard let supplier = supplierField.text, let address = addressField.text else { return }

        station.supplier = supplier
        station.address = address
        viewModel.save(station)
        dismiss(animated: true, completion: dismissCallback)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        addressField.resignFirstResponder()
        supplierField.resignFirstResponder()
    }
    
}
