//
//  AddCurrencyTableViewSource.swift
//  CashConvert
//
//  Created by Chris Tseng on 02/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class AddCurrencyTableViewDataSource: NSObject, UITableViewDataSource {
    
    let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore) {
        self.currencyStore = currencyStore
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyStore.allCurrencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddCurrencyCell") as! AddCurrencyCell
        let currency = currencyStore.allCurrencies[indexPath.row]
        cell.currencyNameLabel.text = currency.name
        cell.flagImageView = nil
        return cell

    }
}
