//
//  CurrencyTableViewDataSource.swift
//  CashConvert
//
//  Created by Chris Tseng on 31/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit

class CurrencyTableViewDataSource: NSObject, UITableViewDataSource {
    
    let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore) {
        self.currencyStore = currencyStore
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyStore.displayCurrencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CurrencyItemCell") as! CurrencyItemCell
        let currency = currencyStore.displayCurrencies[indexPath.row]
        cell.currencyNameLabel.text = currency.name
        cell.flagImageView = nil
        cell.symbolImageView = nil
        cell.inputTextField.text = "\(currency.valueToBase)"
        
        return cell
    }
    
}
