
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
    var type: EchoType
    
    init(mode: MessageMode) {
        bgImageView = UIImageView(image: UIImage(named: "message.png"))
        self.mode = mode
        switch mode{
        case .ReadMessagePaused:
            self.type = .Read;
        case .ReadMessagePull:
            self.type = .Read;
        case .WriteMessage:
            self.type = .Write;
        }
        super.init(frame: bgImageView.bounds)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(bgImageView)
        switch mode {
        case .ReadMessagePaused: setupReadPullingMode();
        case .ReadMessagePull: setupReadPausedMode();
        case .WriteMessage: setupWriteMode();
        }
    }
    
    func setupReadPausedMode() {
        clearMessageView()
        // Add message like "let go to pull down a message" in UILabel, etc.
        var label = UILabel(frame: CGRect(x: self.center.x, y: self.center.y, width: 300, height: 100))
        label.text = "Pull to get an echo."
        self.addSubview(label);
    }
    
    func setupReadPullingMode() {
        clearMessageView()
        // Add UITextField/View/UILabel
        // -set editable->false
        
        //getEcho, set things up
        
    }
    
    func setupWriteMode() {
        clearMessageView()
        // Add UITextField and/or pic field
        
        sendNewEcho();
        
    }
    
    //HTTP REQUEST METHODS
    
    //0 to kill, 1 to keep
    func sendEchoBack(keep:Int){
        
    }
    
    func sendNewEcho(){
        
    }
    
    func getEcho(){
        
    }
    
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
