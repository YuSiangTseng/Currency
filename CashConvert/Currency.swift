//
//  Currency.swift
//  CashConvert
//
//  Created by Chris Tseng on 29/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit

struct Currency: Equatable {
    let name: String
    let valueToBase: Double
    let flagImage: UIImage?
    let longName: String?
    
    init(name: String, valueToBase: Double) {
        self.name = name
        self.valueToBase = valueToBase
        self.flagImage = UIImage(named: name)
        self.longName = currencyFullNames[name]
    }
}

func == (lhs: Currency, rhs: Currency) -> Bool {
    return lhs.name == rhs.name
}