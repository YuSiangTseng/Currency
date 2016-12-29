//
//  Currency.swift
//  CashConvert
//
//  Created by Chris Tseng on 29/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

struct Currency {
    let name: String
    let valueToBase: Double
    
    init(name: String, valueToBase: Double) {
        self.name = name
        self.valueToBase = valueToBase
    }
}
