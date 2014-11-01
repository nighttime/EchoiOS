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


    let mainScroller = UIScrollView();
    let lastPage: Int = 1;
    var bottomWrite: MessageView!;
    var topRead: MessageView!;
    
    // Vars for both message dummies (readPaused and write)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure locationManager
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.delegate = self;
        locationManager.startUpdatingLocation();
        
        //let bgImageView = UIImageView(image: UIImage(named: "splash.png"))
        //bgImageView.backgroundColor = UIColor(red: 0.15, green: 0.02, blue: 0.5, alpha: 1.0)
        //self.view.addSubview(bgImageView)
        
        mainScroller.frame = self.view.bounds
        mainScroller.contentSize = CGSizeMake(self.view.viewWidth, 3 * self.view.viewHeight)
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        mainScroller.pagingEnabled = true
        mainScroller.showsVerticalScrollIndicator = false
        self.view.addSubview(mainScroller)
        
        // Add Message Views to top and bottom view--configure appropriately
        var bottomWrite = MessageView(mode: .WriteMessage);
        bottomWrite.frame = self.view.frame;
        bottomWrite.frame = CGRectOffset(bottomWrite.frame, 0, 2 * self.view.viewHeight);
        mainScroller.addSubview(bottomWrite);
        self.bottomWrite = bottomWrite;
        
        // Center view is a transparent UIView
        var centerPane = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: self.view.viewHeight), size: CGSize(width: self.view.viewWidth, height: self.view.viewHeight)));
        centerPane.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0);
        mainScroller.addSubview(centerPane);
        
        var topRead = MessageView(mode: .ReadMessagePaused);
        topRead.frame = self.view.frame;
        mainScroller.addSubview(topRead);
        self.topRead = topRead;
        
        //Move to the middle pane
        mainScroller.contentOffset = CGPointMake(0.0, self.view.viewHeight);
        
        
        // Mine
        self.view.backgroundColor = UIColor(red: (46.0/255), green: (46.0/255), blue: (46.0/255), alpha: 1.0)
        
        let arrows = SwipeHintArrowsView(type: .Green)
        arrows.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidX(self.view.bounds) + self.view.viewHeight)
        mainScroller.addSubview(arrows)
    }

    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page:Int = (Int)(scrollView.contentOffset.y / scrollView.viewHeight);
        //Up swipe
        if (page == 0){
            self.topRead.mode = .ReadMessagePull;
        }
        else if (page == 1){
            // Do nothing or maybe a shaking animation???
        }
        else{ //Down swipe
            //self.bottomWrite.textFIELDWHATEVERITSCALLED.becomeFirstResponder();
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