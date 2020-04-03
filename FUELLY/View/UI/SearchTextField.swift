//
//  PaddedTextField.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 02.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class SearchTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        addPadding()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addPadding()
    }
    
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        leftView = paddingView
        rightView = paddingView
        leftViewMode = .always
        rightViewMode = .always
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.33
        layer.shadowRadius = 2
    }

}
