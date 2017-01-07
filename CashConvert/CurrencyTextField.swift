//
//  CurrencyTextField.swift
//  CashConvert
//
//  Created by Chris Tseng on 07/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.textRectForBounds(bounds)
        rect.origin.x = 10
        rect.size.width -= 10
        return rect
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.textRectForBounds(bounds)
        rect.origin.x = 10
        rect.size.width -= 10
        return rect
    }
    
}
