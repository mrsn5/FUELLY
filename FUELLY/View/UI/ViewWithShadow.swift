//
//  ViewWithShadow.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

class ViewWithShadow: UIView {

    override func layoutSubviews() {
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = self.traitCollection.userInterfaceStyle == .light ?  UIColor.clear.cgColor : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1).cgColor
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
    }

}
