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
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        currencyStore.moveCurrencyAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let currency = currencyStore.displayCurrencies[indexPath.row]
            self.currencyStore.removeCurrency(currency)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            let title = "Delete \(currency.name)"
//            let message = "Say bye bye to this item ?"
//            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
//            
//            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//            ac.addAction(cancelAction)
//            
//            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
//                self.currencyStore.removeCurrency(currency)
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            })
//            ac.addAction(deleteAction)
//            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
}
