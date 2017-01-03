//
//  AdManager.swift
//  CashConvert
//
//  Created by Chris Tseng on 03/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import GoogleMobileAds

class AdManager: NSObject, GADBannerViewDelegate, GADInterstitialDelegate {
    
    let interstitial  = GADInterstitial(adUnitID: "ca-app-pub-1738448963642929/6136039892")
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-1738448963642929/5478721894"
        adBannerView.delegate = self
        
        return adBannerView
    }()
    lazy var request: GADRequest = {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        return request
    }()
    
    override init() {
        super.init()
        
        loadInterstitialAD()
    }
    
    func loadBannerAd(rootViewController: UIViewController) {
        adBannerView.rootViewController = rootViewController
        adBannerView.loadRequest(request)
    }
    
    func loadInterstitialAD() {
        interstitial.delegate = self
        interstitial.loadRequest(request)
    }
    
    
}
