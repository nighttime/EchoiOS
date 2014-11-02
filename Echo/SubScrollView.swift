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
    var viewPages = [UIView]();
    var messageView: MessageView!;
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
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
        
        // Initialize ScrollView elements
        // Topview is transparent
        var topPane = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.frame.width, height: self.frame.height)));
        topPane.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0);
        subScroller.addSubview(topPane);
        viewPages.append(topPane);
        
        var centerPane = MessageView(mode: .ReadMessagePaused);
        centerPane.frame = self.frame;
        centerPane.frame = CGRectOffset(self.frame, 0.0, self.frame.height);
        subScroller.addSubview(centerPane);
        viewPages.append(centerPane);
        messageView = centerPane;
        
        // Bottom view is transparent
        var bottomPane = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: 2 * self.frame.height), size: CGSize(width: self.frame.width, height: self.frame.height)));
        bottomPane.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0);
        subScroller.addSubview(bottomPane);
        viewPages.append(bottomPane);

        subScroller.contentOffset = CGPointMake(0.0, self.frame.height);
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page: Int = (Int)(scrollView.contentOffset.y / scrollView.viewHeight);
        let curView:UIView = viewPages[page];
        let type: EchoType = messageView.type;
        // if on top "page"
        //   send message
        // else if on bottom "page"
        //   delete message
        // for either, do self.removeFromSuperview()
        
        //Up swipe
        if (page == 0){
            switch type{
                case .Read:
                    messageView.sendEchoBack(1);
                case .Write:
                    messageView.sendNewEcho();
            }
        }
        else if (page == 1){
            // Do nothing
        }
        else{ //Down swipe
            switch type{
                case .Read:
                    echoPane.sendEchoBack(0);
                case .Write:
                    echoPane.removeFromSuperview();
            }
        }
        self.removeFromSuperview();
    }
    
}