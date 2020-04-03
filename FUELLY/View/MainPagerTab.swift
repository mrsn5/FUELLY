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
        
        let backgroundColor: UIColor = self.traitCollection.userInterfaceStyle == .dark ? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1) : .primary()
        view.backgroundColor = backgroundColor
        buttonBarView.backgroundColor = backgroundColor
        settings.style.buttonBarBackgroundColor = backgroundColor
        settings.style.selectedBarBackgroundColor = .primaryLight()
        
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
        let newViewController = AddRefillController(nibName: "AddRefillController", bundle: nil)
        self.present(newViewController, animated: true, completion: nil)
    }
}

