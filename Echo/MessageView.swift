
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
    var imageContent: UIImage!
    var currentEcho:Dictionary<String,Any>
    
    init(mode: MessageMode) {
        bgImageView = UIImageView(image: UIImage(named: "message.png"))
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
        getEchoAndUpdateView();
    }
    
    func setupWriteMode() {
        clearMessageView()
        // Add UITextField and/or pic field
        
        //        sendNewEcho();
        
    }
    
    func uploadImageAndExitView(imageFile: NSData, parameters: Dictionary<String,Any>){
        var path:String
        Alamofire.upload(.POST, "http://localhost:3000/echoPost/uploads", imageFile).responseJSON{(request, response, JSON, error) in
            
        }
    }
    
    //HTTP REQUEST METHODS
    
    //1 to kill, 0 to keep
    func sendEchoBack(keep:Bool){
        //id, deleted, lat, long, datetime, echo_count (updated)
        var location: CLLocationCoordinate2D = locationManager.location.coordinate;
        let lat:Double = location.latitude;
        let lon:Double = location.longitude;
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let time = formatter.stringFromDate(NSDate());
        
        var id: Int
        if keep {id = 0}
        else {id = 1}
        
        var parameterz =
        [  "id" : currentEcho["id"],
            "deleted" : keep,
            "lat" : lat,
            "lon" : lon,
            "datetime" : time,
            "type": currentEcho["contentType"],
            "echo_count": (Int)currentEcho["id"] + 1 ]
        
        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz, encoding: .JSON).response{
            //UPDATE VIEW: EXIT BACK TO MAIN SCREEN
        }
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
        [   "lat" : lat,
            "lon" : lon,
            "datetime" : time,
            "echo_count" : 1,
            "type": contentType
            //"echo_content": echo_content
        ]
        
        //IF THERE IS AN IMAGE, add the content in uploadImageAndExitView
        if (){
            let imageData: NSData = UIImageJPEGRepresentation(imageContent, 1.0);
            uploadImageAndExitView(imageData, parameterz)
            return //Above function exits the view for us
        }
        else{
            echoContent = textContent.text
        }
        
        
        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz, encoding: .JSON).response{
            //UPDATE VIEW: EXIT BACK TO MAIN SCREEN
        }
    }
    
    func getEchoAndUpdateView(){
        Alamofire.request(.GET, "http://echo2.me/get_echo")
            .responseJSON{(_, _, JSON, _) in
                currentEcho = JSON
                console.log(currentEcho)
                //BASED ON currentEcho, UPDATE THE VIEWS
        }
    }
    
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
