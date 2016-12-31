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
    var currencyDataSource: CurrencyTableViewSource?
    
    //MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.beginRefreshing()
        tableView.rowHeight = 75
    }
    
    func setUpTableView(currencyStore: CurrencyStore) {
        refreshControl?.endRefreshing()
        currencyDataSource = CurrencyTableViewSource(currencyStore: currencyStore)
        tableView.dataSource = currencyDataSource
        tableView.reloadData()
    }
    
}
