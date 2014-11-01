
//
//  MessageView.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit
import CoreLocation

class MessageView : UIView {
    
    var mode: MessageMode
    var bgImageView: UIImageView
    var type: EchoType
    var textContent: UILabel!
    var imageContent: UIImage!
    var currentEcho!;
    
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
        getEcho();
//        if (currentEcho["type"] == 0){
//            textContent.text = currentEcho.echo_content;
//        }
//        else if (currentEcho["type"] == 1){
//            imageContent.
//        }
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
    
    //1 to kill, 0 to keep
    func sendEchoBack(keep:Int){
        //id, deleted, lat, long, datetime, echo_count (updated)
        var location: CLLocationCoordinate2D = locationManager.location.coordinate;
        let lat:Double = location.latitude;
        let lon:Double = location.longitude;
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let time = formatter.stringFromDate(NSDate());
        
        var parameterz =
            [   "id" : id,
                "deleted" : keep,
                "lat" : lat,
                "lon" : lon,
                "datetime" : time,
//                "type":
                "echo_count" : echo_count + 1
            ]
        
        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz,encoding: .JSON);
    }
    
    func sendNewEcho(){
        //id, deleted, lat, long, datetime, echo_count (updated)
        var location: CLLocationCoordinate2D = locationManager.location.coordinate;
        let lat:Double = location.latitude;
        let lon:Double = location.longitude;
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let time = formatter.stringFromDate(NSDate());
        
        var parameterz =
            [   "id" : id,
                "deleted" : keep,
                "lat" : lat,
                "lon" : lon,
                "datetime" : time,
                "echo_count" : 1,
//                "type":
                "echo_content": echo_content
        ]
        
        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz,encoding: .JSON);
    }
    
    func getEcho(){
        Alamofire.request(.GET, "http://echo2.me/get_echo")
                .responseJSON{(_, _, JSON, _) in currentEcho = JSON
        }
    }
    
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
