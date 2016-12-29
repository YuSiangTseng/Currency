//
//  CurrencyStore.swift
//  CashConvert
//
//  Created by Chris Tseng on 29/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

class CurrencyStore {
    
    let baseCurrency: Currency
    let allCurrencies: [Currency]
    var displayCurrencies = [Currency]()
    
    init(baseCurrency: Currency, allCurrencies: [Currency]) {
        self.baseCurrency = baseCurrency
        self.allCurrencies = allCurrencies
    }
    
    // Add defaulty currencies 
    
    func addDefaultCurrencies() {
        
        let defaultCurrencyNames = ["GBP", "USD", "EUR", "CAD", "AUD"]
        displayCurrencies = allCurrencies.filter() {
            return defaultCurrencyNames.contains($0.name)
        }
    }
    
}

