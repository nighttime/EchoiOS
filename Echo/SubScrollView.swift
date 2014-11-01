//
//  File.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit

class SubScrollView : UIView, UIScrollViewDelegate {
    
    let subScroller = UIScrollView();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        subScroller.frame = self.bounds
        subScroller.contentSize = CGSizeMake(self.viewWidth, 3 * self.viewHeight)
        subScroller.contentOffset = CGPointMake(0, self.viewHeight)
        subScroller.pagingEnabled = true
        subScroller.showsVerticalScrollIndicator = false
        self.addSubview(subScroller)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.y / scrollView.viewHeight; // 0-based I think
        
        // if on top "page"
        //   send message
        // else if on bottom "page"
        //   delete message
        // for either, do self.removeFromSuperview()
    }
    
}