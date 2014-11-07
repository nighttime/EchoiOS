//
//  HomeViewController.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit
import CoreLocation

let locationManager = CLLocationManager()
let messageCenter = CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
let messageCenterWrite = CGPointMake(messageCenter.x, messageCenter.y - 40)

let ArcherLight = "ArcherPro-Light"
let ArcherExtraLight = "ArcherPro-ExtraLight"

let characterLimit = 200

class HomeViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate, ScrollOptionViewDelegate {

    var mainScroller: UIScrollView!
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
        titleView.center = CGPointMake(CGRectGetMidX(self.view.bounds), 60)
        self.view.addSubview(titleView)
        
        
        mainScroller = UIScrollView(frame: self.view.bounds)
        mainScroller.contentSize = CGSizeMake(self.view.viewWidth, 3 * self.view.viewHeight)
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        mainScroller.pagingEnabled = true
        mainScroller.showsVerticalScrollIndicator = false
        mainScroller.delegate = self
        self.view.addSubview(mainScroller)
        
        let splashView = UIImageView(image: UIImage(named: "splash.png"))
        splashView.center = CGPointMake(messageCenter.x, messageCenter.y + self.view.viewHeight)
        mainScroller.addSubview(splashView)
        
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
            sub.delegate = self
            self.view.addSubview(sub)
            mainScroller.alpha = 0.0
        } else if page == 2 {
            let sub = SubScrollView(mode: .WriteMessage)
            sub.delegate = self
            self.view.addSubview(sub)
            mainScroller.alpha = 0.0
        }
    }
    
    func finishAndEcho(text: String) {
        EchoNetwork.echo(text) {error in}
        returnToMain(recentActionText: "ECHOED")
    }
        
    func finishAndEchoBack(params: [String:AnyObject], mute: Bool) {
        EchoNetwork.echoBack(mute, parameters: params) {error in}
        if mute {
            returnToMain(recentActionText: "MUTED")
        } else {
            returnToMain(recentActionText: "ECHOED")
        }
    }
    
    func finishAndCancel() {
        returnToMain(recentActionText: "CANCELED")
    }
    
    func finishWithError() {
        returnToMain(recentActionText: nil)
    }
    
    func returnToMain(#recentActionText: String?) {
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        
        var mainDelay: NSTimeInterval = 0.25
        
        if let text = recentActionText {
            mainDelay = 1.75
            let label = UILabel(frame: CGRectMake(0, 0, self.view.viewWidth, 80))
            label.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            label.font = UIFont(name: ArcherLight, size: 25)
            label.textAlignment = .Center
            label.textColor = UIColor(red: (138.0/255), green: (217.0/255), blue: (13.0/255), alpha: 0.9)
            label.layer.shadowColor = UIColor.blackColor().CGColor
            label.layer.shadowOpacity = 0.4
            label.layer.shadowRadius = 3
            label.layer.shadowOffset = CGSizeMake(0, 0)
            label.text = text
            label.alpha = 0.0
            self.view.addSubview(label)
            UIView.animateWithDuration(0.75, delay: 0.25, options: (.CurveEaseIn), animations: {
                label.alpha = 1.0
                }, completion: {done in
                    UIView.animateWithDuration(0.75, delay: 0.0, options: (.CurveEaseOut), animations: {
                        label.alpha = 0.0
                        }, completion: {done in
                            label.removeFromSuperview()
                    })
            })
        }
        
        
        UIView.animateWithDuration(0.5, delay: mainDelay, options: (.CurveEaseOut), animations: {
            self.mainScroller.alpha = 1.0
            }, completion: {done in})
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}