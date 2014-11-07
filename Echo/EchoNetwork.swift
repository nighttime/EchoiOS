//
//  EchoNetwork.swift
//  Echo
//
//  Created by Nick McKenna on 11/3/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

/*
 * Behavior of Network Operations
 *
 * - User must get immediate feedback and regain control of the app
 *   • If the server is unreachable or returns an error, silently cache message and try to send later
 *
 */


class EchoNetwork {
    
    class func echo(textContent: String, callback: (NSError?) -> ()) {
        var location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        if let loc = locationManager.location {
            location = loc.coordinate
        }
        let lat: Double = location.latitude
        let lon: Double = location.longitude
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = formatter.stringFromDate(NSDate())
        
        var params: [String:AnyObject] =
        [
            "lat" : lat,
            "lon" : lon,
            "datetime" : time,
            "echo_count" : 1,
            "echoContent" : textContent,
            "contentType" : 0
        ]
        
        Alamofire.request(.POST, "http://www.echo2.me/echoPost/return_echo", parameters: params, encoding: .JSON).response {(request, response, data, error) in
            callback(error)
        }
    }
    
    class func echoBack(delete: Bool, var parameters: [String:AnyObject], callback: (NSError?) -> ()) {
        parameters["deleted"] = NSNumber(bool: delete)
        
        Alamofire.request(.POST, "http://www.echo2.me/echoPost/return_echo", parameters: parameters, encoding: .JSON).response {(request, response, data, error) in
            callback(error)
        }
    }
    
    class func listen(callback: ([String:AnyObject]?, NSError?) -> ()) {
        Alamofire.request(.GET, "http://www.echo2.me/echoGet/get_echo")
            .responseJSON {(request, response, JSON, error) in
                println(response)
                println(JSON)
                println(error)
                println("------------")
                callback(JSON as? [String:AnyObject], error)
        }
    }
    
}

