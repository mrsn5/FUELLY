//
//  ViewController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 31.03.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainPagerTab: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
      return [RefillsController(), StationsController()]
    }

}

