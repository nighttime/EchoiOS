//
//  HomeViewController.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit
import CoreLocation

let locationManager = CLLocationManager();
let messageCenter = CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds) + 20)

class HomeViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {

    var mainScroller: UIScrollView!
    let lastPage = 1
    var bottomWrite: MessageView!
    var topRead: MessageView!
        
    override func preferredStatusBarStyle() -> UIStatusBarStyle { return .LightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure locationManager
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        
        self.view.backgroundColor = UIColor(red: (46.0/255), green: (46.0/255), blue: (46.0/255), alpha: 1.0)
        
        let titleView = UIImageView(image: UIImage(named: "title.png"))
        titleView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 70)
        self.view.addSubview(titleView)
        
        let splashView = UIImageView(image: UIImage(named: "splash.png"))
        splashView.center = messageCenter
        self.view.addSubview(splashView)
        
        
        mainScroller = UIScrollView(frame: self.view.bounds)
        mainScroller.contentSize = CGSizeMake(self.view.viewWidth, 3 * self.view.viewHeight)
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        mainScroller.pagingEnabled = true
        mainScroller.showsVerticalScrollIndicator = false
        mainScroller.delegate = self
        self.view.addSubview(mainScroller)
        
        // Add Message Views to top and bottom view
        bottomWrite = MessageView(mode: .WriteMessage)
        bottomWrite.center = CGPointMake(CGRectGetMidX(mainScroller.bounds), messageCenter.y + (2 * self.view.viewHeight))
        mainScroller.addSubview(bottomWrite)
        
        topRead = MessageView(mode: .ReadMessagePaused)
        topRead.center = CGPointMake(CGRectGetMidX(mainScroller.bounds), messageCenter.y)
        mainScroller.addSubview(topRead)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.y / scrollView.viewHeight)
        if page == 0 {
            let sub = SubScrollView(mode: .ReadMessagePull)
            self.view.addSubview(sub)
            topRead.hidden = true
        } else if page == 2 {
            let sub = SubScrollView(mode: .WriteMessage)
            self.view.addSubview(sub)
            bottomWrite.hidden = true
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // do message.textField.resignFirstResponder()
            //self.bottomWrite.textFIELDWHATEVERITSCALLED.becomeFirstResponder();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}