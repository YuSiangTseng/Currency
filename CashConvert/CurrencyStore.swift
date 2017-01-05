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
    var currentBaseAmount: Double? = 1
    
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
        displayCurrencies = displayCurrencies.map { (currency) -> Currency in
            let newRate = ratesToPreviousBaseCurrency * currency.valueToBase
            return Currency(name: currency.name, valueToBase: newRate)
        }
        baseCurrency = Currency(name: currency.name, valueToBase: 1.0)
        currentBaseAmount = nil

    }
    
    func addCurrencyToDisplayCurrencies(currency: Currency) {
        if !displayCurrencies.contains({ $0 == currency}) {
            displayCurrencies.append(currency)
        }
    }
    
    func removeCurrency(currency: Currency) {
        if let index = displayCurrencies.indexOf(currency) {
            displayCurrencies.removeAtIndex(index)
        }
        
    }
    
    func moveCurrencyAtIndex(fromIndex: Int, toIndex: Int) {
        guard fromIndex != toIndex else { return }
        
        let movedCurrency = displayCurrencies[fromIndex]
        displayCurrencies.removeAtIndex(fromIndex)
        displayCurrencies.insert(movedCurrency, atIndex: toIndex)
    }
    
    func amountStringForCurrency(currency: Currency) -> String {
        if let amount = currentBaseAmount {
            return "\(currency.valueToBase * amount)"
        } else {
            return ""
        }
        
    }
    
}

