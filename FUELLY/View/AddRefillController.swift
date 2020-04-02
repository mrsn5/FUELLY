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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let r = Refill()
        r.station = Station()
        viewModel.save(r)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
