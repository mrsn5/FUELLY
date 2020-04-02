//
//  ViewController.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 31.03.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainPagerTab: BaseButtonBarPagerTabStripViewController<PagerTabCell> {

    override func viewDidLoad() {
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: PagerTabCell.reuseID, bundle: Bundle(for: PagerTabCell.self), width: { _ in return 55.0 })
        
        settings.style.buttonBarBackgroundColor = .primary()
        settings.style.selectedBarBackgroundColor = .white
        
        changeCurrentIndexProgressive = { (oldCell: PagerTabCell?, newCell: PagerTabCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.iconImage.tintColor = .primaryLight()
            newCell?.iconImage.tintColor = .white
        }
        
        super.viewDidLoad()
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
      return [RefillsController(), StationsController()]
    }

    override func configure(cell: PagerTabCell, for indicatorInfo: IndicatorInfo) {
        cell.iconImage.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let newViewController = PickStationView(nibName: "PickStationView", bundle: nil)
        self.present(newViewController, animated: true, completion: nil)
    }
}

