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
    var viewPages: [UIView] = []
    var messageView: MessageView
    var upArrows: SwipeHintArrowsView!
    var downArrows: SwipeHintArrowsView!
    var delegate: ScrollOptionViewDelegate? = nil
    
    init(mode: MessageMode) {
        messageView = MessageView(mode: mode)
        super.init(frame: UIScreen.mainScreen().bounds)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func failAtListening() {
        UIView.animateWithDuration(0.75, delay: 0.0, options: (.CurveEaseOut), animations: {
            self.alpha = 0.0
            }, completion: {done in
                self.delegate?.finishWithError()
                self.removeFromSuperview()
        })
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        subScroller.frame = self.bounds
        subScroller.contentSize = CGSizeMake(self.viewWidth, 3 * self.viewHeight)
        subScroller.contentOffset = CGPointMake(0, self.viewHeight)
        subScroller.pagingEnabled = true
        subScroller.showsVerticalScrollIndicator = false
        subScroller.delegate = self
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
        
        if messageView.mode == .WriteMessage {
            messageView.beginWriteMode()
        } else if messageView.mode == .ReadMessagePull  {
            EchoNetwork.listen {params, error in
                println(error)
                if params == nil || error != nil {
                    UIAlertView(title: "Error", message: "Couldn't hear any echoes...", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
                    self.failAtListening()
                } else {
                    self.messageView.textView.text = params!["econtent"] as String
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.y / scrollView.viewHeight)
        if page == 0 {
            switch messageView.mode {
                case MessageMode.ReadMessagePull, MessageMode.ReadMessagePaused:
                    delegate?.finishAndEchoBack(messageView.params, mute: true)
                    self.removeFromSuperview()
                case MessageMode.WriteMessage:
                    delegate?.finishAndCancel()
                    self.removeFromSuperview()
            }
        } else if page == 2 {
            switch messageView.mode {
                case MessageMode.ReadMessagePull, MessageMode.ReadMessagePaused:
                    delegate?.finishAndEchoBack(messageView.params, mute: false)
                    self.removeFromSuperview()
                case MessageMode.WriteMessage:
                    delegate?.finishAndEcho(messageView.message)
                    self.removeFromSuperview()
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        messageView.textView.resignFirstResponder()
    }
}

protocol ScrollOptionViewDelegate {
    func finishAndEcho(text: String)
    func finishAndEchoBack(params: [String:AnyObject], mute: Bool)
    func finishAndCancel()
    func finishWithError()
}

