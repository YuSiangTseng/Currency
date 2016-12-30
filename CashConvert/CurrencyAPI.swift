//
//  CurrencyAPI.swift
//  CashConvert
//
//  Created by Chris Tseng on 30/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import Foundation


import Foundation


enum CurrencyResult {
    case Success(Currency, [Currency])
    case Failure(ErrorType)
}

enum CurrencyAPIError: ErrorType {
    case InvalidJSONData
}

struct CurrencyAPI {
    
    let baseURLString = "https://api.fixer.io/latest?base="
    let session = NSURLSession.sharedSession()
    
    private func urlWithBaseCurrency(currency: Currency?) -> NSURL {
        
        let base = currency == nil ? "GBP" : currency!.name
        return NSURL(string: baseURLString + base)!
        
    }
    
    func fetchCurrencies(baseCurrency baseCurrency: Currency?, completion: (CurrencyResult) -> Void) {
        
        let url = urlWithBaseCurrency(baseCurrency)
        session.dataTaskWithURL(url) { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                let result = self.currencyResultWithData(data)
                completion(result)
            }
        }.resume()
        
    }
    
    private func currencyResultWithData(data: NSData?) -> CurrencyResult {
        
        guard data != nil,
            let jsonObject = try? NSJSONSerialization.JSONObjectWithData(data!, options: []),
            let base = jsonObject["base"] as? String,
            let rates = jsonObject["rates"] as? [String : Double] else {
                
                return .Failure(CurrencyAPIError.InvalidJSONData)
            
        }
        
        return currencyResultWithRatesDictionary(rates, baseName: base)
       
    }
    
    private func currencyResultWithRatesDictionary(rates: [String : Double], baseName: String) -> CurrencyResult {
        
        let baseCurrency = Currency(name: baseName, valueToBase: 1.0)
        var currencies = [baseCurrency]
        
        for (name, value) in rates {
            currencies.append(
                Currency(name: name, valueToBase: value)
            )
        }
        
        if currencies.count > 1 {
            return .Success(baseCurrency, currencies)
        } else {
            return .Failure(CurrencyAPIError.InvalidJSONData)
        }
        
    }
    
}