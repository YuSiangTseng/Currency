//
//  CurrencyStore.swift
//  CashConvert
//
//  Created by Chris Tseng on 29/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

class CurrencyStore {
    
    private (set) var baseCurrency: Currency
    private (set) var allCurrencies: [Currency]
    private (set) var displayCurrencies = [Currency]()
    
    init(baseCurrency: Currency, allCurrencies: [Currency]) {
        self.baseCurrency = baseCurrency
        self.allCurrencies = allCurrencies
        addDefaultCurrencies()
    }
    
    // Add defaulty currencies 
    
    private func addDefaultCurrencies() {
        
        let defaultCurrencyNames = ["GBP", "USD", "EUR", "CAD", "AUD"]
        displayCurrencies = allCurrencies.filter() {
            return defaultCurrencyNames.contains($0.name)
        }
    }
    
    func changeBaseCurrency(currency: Currency) {
        
        let ratesToPreviousBaseCurrency = baseCurrency.valueToBase / currency.valueToBase
        allCurrencies = allCurrencies.map { (currency) -> Currency in
            let newRate = ratesToPreviousBaseCurrency * currency.valueToBase
            return Currency(name: currency.name, valueToBase: newRate)
        }
        baseCurrency = Currency(name: currency.name, valueToBase: 1.0)
    
    }
    
    func addCurrencyToDisplayCurrencies(currency: Currency) {
        if !displayCurrencies.contains({ $0.name == currency.name }) {
            displayCurrencies.append(currency)
        }
    }
    
}

