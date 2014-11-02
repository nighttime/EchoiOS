
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
    var imageContent: UIImage?
    var currentEcho:Dictionary<String,Any>
    
    init(mode: MessageMode) {
        bgImageView = UIImageView(image: UIImage(named: "message.png"))
        self.mode = mode
        self.currentEcho = [:]
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
        getEchoAndUpdateView();
    }
    
    func setupWriteMode() {
        clearMessageView()
        // Add UITextField and/or pic field
    }
    
    func uploadImageAndExitView(imageFile: NSData, parameters: Dictionary<String,Any>){
        var path:String
//        Alamofire.upload(.POST, "http://localhost:3000/echoPost/uploads", imageFile).responseJSON{(request, response, JSON, error) in
//            
//        }
    }
    
    //HTTP REQUEST METHODS
    
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
            "echo_count": ((currentEcho["id"] as Int) + 1)
        ]
        
//        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz, encoding: .JSON).response{(request, response, data, error) in
//            //UPDATE VIEW: EXIT BACK TO MAIN SCREEN
//        }
    }
    
    func sendNewEcho(){
        //id, deleted, lat, long, datetime, echo_count (updated)
        var location: CLLocationCoordinate2D = locationManager.location.coordinate;
        let lat:Double = location.latitude;
        let lon:Double = location.longitude;
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let time = formatter.stringFromDate(NSDate());
        

        var parameterz: Dictionary<String, Any> =
        [   "lat" : lat,
            "lon" : lon,
            "datetime" : time,
            "echo_count" : 1
        ]
        
        //IF THERE IS AN IMAGE, add the content in uploadImageAndExitView
        if let image = imageContent {
            let imageData = UIImageJPEGRepresentation(image, 1.0);
            uploadImageAndExitView(imageData!, parameters: parameterz)
            return //Above function exits the view for us
        } else {
            parameterz["echoContent"] = textContent.text
            parameterz["contentType"] = 0
        }
        
        
//        Alamofire.request(.POST, "http://echo2.me/return_echo", parameters: parameterz, encoding: .JSON).response{(request, response, data, error) in
//            //UPDATE VIEW: EXIT BACK TO MAIN SCREEN
//        }
    }
    
    func getEchoAndUpdateView(){
//        Alamofire.request(.GET, "http://echo2.me/get_echo")
//            .responseJSON{(_, _, JSON, _) in
//                currentEcho = JSON
//                console.log(currentEcho)
//                if currentEcho["contentType"] == 1{
//                    Alamofire.request(.GET, "http://echo2.me/uploads/get_echo", ["path": currentEcho["content"], encoding: .JSON ]).response{(request, response, data, error) in
//                            imageContent = response
//                    }
//                    return
//                }
//                // currentEcho["content"]
//                //UPDATE VIEW WITH TEXT
//        }
    }
    
    
    func clearMessageView() {
        for s in bgImageView.subviews {
            s.removeFromSuperview()
        }
    }
    
}
