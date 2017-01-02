//
//  AddCurrencyViewController.swift
//  CashConvert
//
//  Created by Chris Tseng on 02/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import UIKit

class AddCurrencyViewController: UITableViewController {
    
    var currencyStore: CurrencyStore? {
        didSet {
            setUpTableView(currencyStore!)
        }
    }
    var addCurrencyDataSource: AddCurrencyTableViewDataSource?
    
    //MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75
    }
    
    func setUpTableView(currencyStore: CurrencyStore) {
        addCurrencyDataSource = AddCurrencyTableViewDataSource(currencyStore: currencyStore)
        tableView.dataSource = addCurrencyDataSource
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currencyStore?.addCurrencyToDisplayCurrencies((currencyStore?.allCurrencies[indexPath.row])!)
        navigationController?.popViewControllerAnimated(true)
    }
}
