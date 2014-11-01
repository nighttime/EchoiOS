//
//  HomeViewController.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    let mainScroller = UIScrollView();
    
    // Vars for both message dummies (readPaused and write)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(image: UIImage(named: "splash.png"))
        bgImageView.backgroundColor = UIColor(red: 0.15, green: 0.02, blue: 0.5, alpha: 1.0)
        self.view.addSubview(bgImageView)
        
        mainScroller.frame = self.view.bounds
        mainScroller.contentSize = CGSizeMake(self.view.viewWidth, 3 * self.view.viewHeight)
        mainScroller.contentOffset = CGPointMake(0, self.view.viewHeight)
        mainScroller.pagingEnabled = true
        mainScroller.showsVerticalScrollIndicator = false
        self.view.addSubview(mainScroller)
        
        // Add details to "center" page of scroller
        // - should have label(s) for instructions / image instead?
        
        // Add Message Views to top and bottom view--configure appropriately
    }

    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.y / scrollView.viewHeight;
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}