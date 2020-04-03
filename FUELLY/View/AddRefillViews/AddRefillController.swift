//
//  AddRefillController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class AddRefillController: UIViewController {

    var viewModel = RefillsViewModel.shared
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var fuelField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var stationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(dismissGesture)
    }
    @IBAction func confirmed(_ sender: Any) {
        
    }
    
    @IBAction func stationTapped(_ sender: Any) {
        let newViewController = StationPicker(nibName: "StationPicker", bundle: nil)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        quantityField.resignFirstResponder()
        fuelField.resignFirstResponder()
        priceField.resignFirstResponder()
    }
    
    @objc func stationFieldTapped (_ sender: UITapGestureRecognizer) {
        print("TAPTAP")
    }
}
