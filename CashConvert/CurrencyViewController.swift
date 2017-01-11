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
        showBannerAd()
        title = "Currency"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK:- Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addCurrency" {
            showAddCurrency(segue)
            if adManager.interstitial.isReady {
                adManager.interstitial.presentFromRootViewController(self)
            }
        } else if segue.identifier == "showWebPage" {
            showWebPage(segue)
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
    
    //MARK:- View Setup
    
    func showBannerAd() {
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.addSubview(adManager.adBannerView)
        adManager.loadBannerAd(self)
    }
    
    func setUpTableView(currencyStore: CurrencyStore) {
        tableView.rowHeight = 90
        refreshControl?.endRefreshing()
        currencyDataSource = CurrencyTableViewDataSource(currencyStore: currencyStore)
        currencyDataSource?.presentAlertFrom = self
        tableView.dataSource = currencyDataSource
        tableView.reloadData()
        
    }
    
    func enableNavigationItems(enabled enabled: Bool) {
        navigationItem.leftBarButtonItem?.enabled = enabled
        navigationItem.rightBarButtonItem?.enabled = enabled
    }
    
    //MARK:- TextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        guard let indexPath = indexPathWithTextField(textField),
            let newBaseCurrency = currencyStore?.displayCurrencies[indexPath.row] else {
                return
        }
        
        addCurrentBaseAmountToStoreWithTextField(textField)
        emptyTextFields()
        currencyStore?.changeBaseCurrency(newBaseCurrency)
        enableNavigationItems(enabled: false)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        enableNavigationItems(enabled: true)
        addCurrentBaseAmountToStoreWithTextField(textField)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.rangeOfString(".") != nil && string.rangeOfString(".") != nil {
            return false
        } else {
            return true
        }
        
    }
    
    @IBAction func textFieldInCellDataChanged(textField: UITextField) {
        guard let currencyStore = self.currencyStore else {
            return
        }
        addCurrentBaseAmountToStoreWithTextField(textField)
        for i in 0 ..< currencyStore.displayCurrencies.count {
            if i != indexPathWithTextField(textField)?.row {
                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? CurrencyItemCell {
                    let currency = currencyStore.displayCurrencies[i]
                    cell.inputTextField.text = currencyStore.amountStringForCurrency(currency)
                }
            }
        }
    }
    
    //MARK:- TableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.frame.origin.x = 50.0
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: .CurveEaseIn, animations: {
            cell.frame.origin.x = 0.0
        }, completion: nil)
        
        let currencyCell = cell as! CurrencyItemCell
        currencyCell.inputTextField.delegate = self
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !isUserEditing() {
            performSegueWithIdentifier("showWebPage", sender: nil)
        } else {
            view.endEditing(true)
        }
    }
    
    //MARK:- SrollviewDelegate
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        refreshControl = nil
    }
    
    //MARK:- Utility
    
    func indexPathWithTextField(textField: UITextField) -> NSIndexPath? {
        let pointInCell = textField.frame.origin
        let pointInTableView = tableView.convertPoint(pointInCell, fromView: textField.superview)
        return tableView.indexPathForRowAtPoint(pointInTableView)
    }
    
    func emptyTextFields() {
        for cell in tableView.visibleCells {
            if let cell = cell as? CurrencyItemCell {
                cell.inputTextField.text = ""
            }
        }
    }
    
    func addCurrentBaseAmountToStoreWithTextField(textField: UITextField) {
        if let currencyBaseTextField = textField.text {
            currencyStore?.currentBaseAmount = Double(currencyBaseTextField)
        }
        
    }
    
    func isUserEditing() -> Bool {
        var editingField = false
        for cell in tableView.visibleCells {
            if let cell = cell as? CurrencyItemCell {
                if cell.inputTextField.isFirstResponder() {
                    editingField = true
                    break
                }
            }
        }
        return editingField
    }
    
    func showErrorMessage() {
        //self.refreshControl?.endRefreshing()
        let title = "Internet problem"
        let message = "Please press reload to try it again."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let reloadAction = UIAlertAction(title: "Reload", style: .Default) { (action) -> Void in
            //self.refreshControl?.beginRefreshing()
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "reloadData", object: self))
        }
        ac.addAction(reloadAction)
        presentViewController(ac, animated: true, completion: nil)
    }
    
}
