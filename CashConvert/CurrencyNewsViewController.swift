//
//  CurrencyNewsViewController.swift
//
//
//  Created by Chris Tseng on 02/01/2017.
//
//

import UIKit

class CurrencyNewsViewController: UIViewController, UIWebViewDelegate {
    
    var currency: Currency!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        currencyNews()
    }
    
    func currencyNews() {
        
        if let url = NSURL(string: "https://www.google.co.uk/?gfe_rd=cr&ei=HzJYWLOnNaTc8AeU1oWIAg#q=\(currency.name + "+currency")&tbm=nws") {
            
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
            
        }
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(currencyNews))
    }
}
