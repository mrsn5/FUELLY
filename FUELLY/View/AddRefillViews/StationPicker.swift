//
//  StationPicker.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class StationPicker: UIViewController {

    let viewModel = StationsViewModel.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AddNewCell.nib, forCellReuseIdentifier: AddNewCell.reuseID)
        
        tableView.register(SimpleCell.nib, forCellReuseIdentifier: SimpleCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = viewModel.dataSource
        viewModel.fetch()
    }


}

extension StationPicker: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let newViewController = MapStationView(nibName: "MapStationView", bundle: nil)
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
}
