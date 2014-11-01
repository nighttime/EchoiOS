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

class HomeViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {

    let mainScroller = UIScrollView()
    let lastPage = 1
    var bottomWrite: MessageView!
    var topRead: MessageView!
    
    var messageCenter: CGPoint!
    
    // Vars for both message dummies (readPaused and write)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageCenter = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 40)
        
        //Configure locationManager
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        
        self.view.backgroundColor = UIColor(red: (46.0/255), green: (46.0/255), blue: (46.0/255), alpha: 1.0)
        
        let titleView = UIImageView(image: UIImage(named: "title.png"))
        titleView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 130)
        self.view.addSubview(titleView)
        
        let splashView = UIImageView(image: UIImage(named: "splash.png"))
        splashView.center = messageCenter
        self.view.addSubview(splashView)
        
        
        mainScroller.frame = self.view.bounds
        mainScroller.contentSize = CGSizeMake(self.view.viewWidth, 3 * self.view.viewHeight)
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        mainScroller.pagingEnabled = true
        mainScroller.showsVerticalScrollIndicator = false
        self.view.addSubview(mainScroller)
        
        // Add Message Views to top and bottom view
        bottomWrite = MessageView(mode: .WriteMessage)
        bottomWrite.center = CGPointMake(CGRectGetMidX(mainScroller.bounds), messageCenter.y + (2 * self.view.viewHeight))
        mainScroller.addSubview(bottomWrite)
        
        topRead = MessageView(mode: .ReadMessagePaused)
        bottomWrite.center = CGPointMake(CGRectGetMidX(mainScroller.bounds), messageCenter.y)
        mainScroller.addSubview(topRead)
    }

    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.y / scrollView.viewHeight)
        if page == 0 {
            if topRead.mode == .ReadMessagePaused {
                topRead.mode = .ReadMessagePull
            }
        } else if page == 2 {
            self.bottomWrite.textFIELDWHATEVERITSCALLED.becomeFirstResponder();
        }
        // figure out what the user just did
        // if "home" (ie are they returning from echoing a downloaded message or cancelling a written message?)
        //   maybe keep a prevPage variable and compare to page?
        // else if "pulled from server"
        //   overlay SubScrollView and set visible dummy.hidden->true
        // else if "writing a new message"
        //   do message.textField.becomeFirstResponder()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // do message.textField.resignFirstResponder()
            //self.bottomWrite.textFIELDWHATEVERITSCALLED.becomeFirstResponder();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}