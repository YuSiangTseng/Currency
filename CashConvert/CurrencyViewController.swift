//
//  CurrencyViewController.swift
//  CashConvert
//
//  Created by Chris Tseng on 31/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    var currencyStore: CurrencyStore? {
        didSet {
            setUpTableView()
        }
    }
    
    func setUpTableView() {
        print(currencyStore?.displayCurrencies)
    }
}
