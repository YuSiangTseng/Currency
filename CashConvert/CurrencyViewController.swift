//
//  CurrencyViewController.swift
//  CashConvert
//
//  Created by Chris Tseng on 31/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit

class CurrencyViewController: UITableViewController {

    var currencyStore: CurrencyStore? {
        didSet {
            setUpTableView(currencyStore!)
        }
    }
    var currencyDataSource: CurrencyTableViewDataSource?
    
    //MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.beginRefreshing()
        tableView.rowHeight = 75
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebPage" {
            showWebPage(segue)
        } else if segue.identifier == "addCurrency" {
            showAddCurrency(segue)
        }
    }
    
    func showWebPage(segue: UIStoryboardSegue) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let currency = currencyStore?.displayCurrencies[row]
            let currencyNewsViewController = segue.destinationViewController as! CurrencyNewsViewController
            currencyNewsViewController.currency = currency
        }
    }
    
    func showAddCurrency(segue: UIStoryboardSegue) {
        let addCurrencyViewController = segue.destinationViewController as! AddCurrencyViewController
        addCurrencyViewController.currencyStore = currencyStore
    }
    
    func setUpTableView(currencyStore: CurrencyStore) {
        refreshControl?.endRefreshing()
        currencyDataSource = CurrencyTableViewDataSource(currencyStore: currencyStore)
        tableView.dataSource = currencyDataSource
        tableView.reloadData()
    }

    
}
