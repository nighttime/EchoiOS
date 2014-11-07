
//
//  MessageView.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MessageView : UIView, UITextViewDelegate {
    
    var mode: MessageMode
    var bgImageView: UIImageView
    var textView: UITextView!
    var echoNumView: UITextField!
    var imageContent: UIImage?
    var params: [String:AnyObject]
    
    var message: String {
        get {
            return textView.text
        }
    }
    
    init(mode: MessageMode) {
        bgImageView = UIImageView(image: UIImage(named: "message.png"))
        self.mode = mode
        self.params = [:]
        super.init(frame: bgImageView.bounds)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.addSubview(bgImageView)
        
        let inset: CGFloat = 10
        textView = UITextView(frame: CGRectMake(inset, 70 + inset, self.viewWidth - (2 * inset), self.viewHeight - 140 - (2 * inset)))
        textView.font = UIFont(name: ArcherLight, size: 22)
        textView.textAlignment = .Center
        textView.textColor = UIColor(red: (138.0/255), green: (217.0/255), blue: (13.0/255), alpha: 1.0)
        textView.layer.shadowColor = UIColor.blackColor().CGColor
        textView.layer.shadowOpacity = 0.4
        textView.layer.shadowRadius = 3
        textView.layer.shadowOffset = CGSizeMake(0, 0)
        textView.backgroundColor = UIColor.clearColor()
        switch mode {
        case .ReadMessagePaused:
            textView.text = "Pull to read an echo."
            textView.editable = false
        case .ReadMessagePull:
            textView.text = "Listening for echoes..."
            textView.editable = false
        case .WriteMessage:
            textView.text = "Echo your own message."
            textView.editable = true
        }
        
        self.addSubview(textView)
        
        
        echoNumView = UITextField(frame: CGRectMake(inset * 2, textView.frame.origin.y + textView.viewHeight + (2 * inset), self.viewWidth - (4 * inset), 25))
        echoNumView.font = UIFont(name: ArcherExtraLight, size: 18)
        echoNumView.textAlignment = .Center
        echoNumView.textColor = UIColor(red: (138.0/255), green: (217.0/255), blue: (13.0/255), alpha: 0.9)
        echoNumView.layer.shadowColor = UIColor.blackColor().CGColor
        echoNumView.layer.shadowOpacity = 0.4
        echoNumView.layer.shadowRadius = 3
        echoNumView.layer.shadowOffset = CGSizeMake(0, 0)
        echoNumView.text = ""
        self.addSubview(echoNumView)
    }
    
    func beginWriteMode() {
        UIView.animateWithDuration(0.15, delay: 0.0, options: (.CurveEaseOut), animations: {
            self.textView.alpha = 0.0
            }, completion: {done in
                self.textView.text = ""
                self.textView.alpha = 1.0
                self.textView.becomeFirstResponder()
        })
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newLength = (textView.text?.utf16Count ?? 0) + text.utf16Count - range.length
        return newLength <= characterLimit
    }
}
