//
//  CurrencyItemCell.swift
//  CashConvert
//
//  Created by Chris Tseng on 31/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit

class CurrencyItemCell: UITableViewCell {
    
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var currencyNameLabel: UILabel!
    
    override func awakeFromNib() {
        inputTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        inputTextField.layer.borderWidth = 1.0
        inputTextField.tintColor = UIColor(red: 90/255, green: 202/255, blue: 250/255, alpha: 1)
    }
    
}
