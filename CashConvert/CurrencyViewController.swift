//
//  CurrencyViewController.swift
//  CashConvert
//
//  Created by Chris Tseng on 31/12/2016.
//  Copyright © 2016 Tseng Yu Siang. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CurrencyViewController: UITableViewController, GADBannerViewDelegate, GADInterstitialDelegate, UITextFieldDelegate {

    var currencyStore: CurrencyStore? {
        didSet {
            setUpTableView(currencyStore!)
        }
    }
    var currencyDataSource: CurrencyTableViewDataSource?
    var adManager: AdManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    //MARK:- view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl?.beginRefreshing()
        tableView.rowHeight = 75
        showBannerAd()
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
            if adManager.interstitial.isReady {
                adManager.interstitial.presentFromRootViewController(self)
            }
        }
    }
    
    func showBannerAd() {
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.addSubview(adManager.adBannerView)
        adManager.loadBannerAd(self)
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        emptyTextField(textField)
    }
    
    func emptyTextField(textField: UITextField) {
        for i in 0 ..< currencyStore!.displayCurrencies.count {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            if let cellAtIndexPath = tableView.cellForRowAtIndexPath(indexPath) as? CurrencyItemCell {
                cellAtIndexPath.inputTextField.text = ""
            }
        }
    }

}
