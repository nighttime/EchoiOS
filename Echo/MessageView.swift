
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
    var textContent: UITextField!
    var imageContent: UIImage!
    
    
    //var currentEcho!
    
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
        
        let inset: CGFloat = 10
        textContent = UITextField(frame: CGRectMake(inset, 150 + inset, self.viewWidth - (2 * inset), self.viewHeight - 300 - (2 * inset)))
        
        
        switch mode {
            case .ReadMessagePaused: setupReadPullingMode();
            case .ReadMessagePull: setupReadPausedMode();
            case .WriteMessage: setupWriteMode();
        }
    }
    
    func setupReadPausedMode() {
        clearMessageView()
        var label = UILabel(frame: CGRectMake(self.center.x, self.center.y, 300, 100))
        label.text = "Pull to get an echo."
        self.addSubview(label);
    }
    
    func setupReadPullingMode() {
        clearMessageView()
        getEcho();
        /*if (currentEcho["type"] == 0){
            textContent.text = currentEcho.echo_content;
        }
        else if (currentEcho["type"] == 1){
            imageContent.
        }*/
        
        // Add UITextField/View/UILabel
        // -set editable->false
        
        //getEcho, set things up
        
    }
    
    func setupWriteMode() {
        clearMessageView()
        // Add UITextField and/or pic field
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
        

//        var parameterz =
//            [   "id" : id,
//                "deleted" : keep,
//                "lat" : lat,
//                "lon" : lon,
//                "datetime" : time,
////                "type":
//                "echo_count" : echo_count + 1
//            ]
        
//        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz,encoding: .JSON);*/
    }
    
    func sendNewEcho(){
        //id, deleted, lat, long, datetime, echo_count (updated)
        var location: CLLocationCoordinate2D = locationManager.location.coordinate;
        let lat:Double = location.latitude;
        let lon:Double = location.longitude;
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let time = formatter.stringFromDate(NSDate());
        

//        var parameterz =
//            [   "id" : id,
//                "deleted" : keep,
//                "lat" : lat,
//                "lon" : lon,
//                "datetime" : time,
//                "echo_count" : 1,
////                "type":
//                "echo_content": echo_content
//        ]
//        
//        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz,encoding: .JSON);*/
    }
    
    func getEcho(){
        /*Alamofire.request(.GET, "http://echo2.me/get_echo")
                .responseJSON{(_, _, JSON, _) in currentEcho = JSON
        }*/
    }
    
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
