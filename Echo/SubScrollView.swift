//
//  File.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit

class SubScrollView : UIView, UIScrollViewDelegate {
    
    let subScroller = UIScrollView()
    var viewPages = [UIView]()
    var messageView: MessageView
    var upArrows: SwipeHintArrowsView!
    var downArrows: SwipeHintArrowsView!
    
    init(mode: MessageMode) {
        messageView = MessageView(mode: mode)
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
        
        messageView.center = CGPointMake(messageCenter.x, messageCenter.y + self.viewHeight)
        subScroller.addSubview(messageView)
        
        upArrows = SwipeHintArrowsView(type: .Green)
        upArrows.center = CGPointMake(messageCenter.x, self.viewHeight + messageCenter.y - messageView.viewHeight/2 - upArrows.viewHeight/4)
        subScroller.addSubview(upArrows)
        
        downArrows = SwipeHintArrowsView(type: .Red)
        downArrows.center = CGPointMake(messageCenter.x, self.viewHeight + messageCenter.y + messageView.viewHeight/2 + downArrows.viewHeight/4)
        subScroller.addSubview(downArrows)
        
        upArrows.animate()
        downArrows.animate()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.y / scrollView.viewHeight)
//        if page == 0 {
//            switch messageView.mode {
//                case .ReadMessagePull, .ReadMessagePaused:
//                    messageView.sendEchoBack(1)
//                case .WriteMessage:
//                    messageView.sendNewEcho()
//            }
//        } else if page == 2 {
//            switch messageView.mode {
//                case .ReadMessagePull, .ReadMessagePaused:
//                    messageView.sendEchoBack(0);
//                case .WriteMessage:
//                    messageView.removeFromSuperview();
//            }
//        }
    }

}




