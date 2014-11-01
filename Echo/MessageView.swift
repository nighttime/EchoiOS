
//
//  MessageView.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit

class MessageView : UIView {
    
    var mode: MessageMode
    var bgImageView: UIImageView
    
    init(mode: MessageMode) {
        bgImageView = UIImageView(image: UIImage(named: "message.png"))
        self.mode = mode
        super.init(frame: bgImageView.bounds)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(bgImageView)
        switch mode {
        case .ReadMessagePaused: setupReadPullingMode()
        case .ReadMessagePull: setupReadPausedMode()
        case .WriteMessage: setupWriteMode()
        }
    }
    
    func setupReadPausedMode() {
        clearMessageView()
        // Add message like "let go to pull down a message" in UILabel, etc.
    }
    
    func setupReadPullingMode() {
        clearMessageView()
        // Add UITextField/View/UILabel
        // -set editable->false
    }
    
    func setupWriteMode() {
        clearMessageView()
        // Add UITextField
        // pull from server
    }
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
