//
//  Support.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit


extension UIView {
    var viewHeight:CGFloat {
        get {
            return self.bounds.height
        }
    }
    var viewWidth:CGFloat {
        get {
            return self.bounds.width
        }
    }
}

enum MessageMode {
    case ReadMessagePull
    case ReadMessagePaused
    case WriteMessage
}

enum EchoType{
    case Write
    case Read
}