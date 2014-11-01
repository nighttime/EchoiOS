//
//  SwipeHintArrowsView.swift
//  Echo
//
//  Created by Nick McKenna on 11/1/14.
//  Copyright (c) 2014 nighttime software. All rights reserved.
//

import UIKit

enum ArrowType {
    case Green
    case Red
}


class SwipeHintArrowsView : UIView {
    
    var type: ArrowType
    
    let arrow1 = UIImageView(image: UIImage(named: "arrowGreen.png"))
    let arrow2 = UIImageView(image: UIImage(named: "arrowGreen.png"))
    let arrow3 = UIImageView(image: UIImage(named: "arrowGreen.png"))
    
    let low: CGFloat = 0.2
    let high: CGFloat = 1.0
    
    let inDur: NSTimeInterval = 1.0
    let outDur: NSTimeInterval = 0.75
    
    init(type: ArrowType) {
        self.type = type
        super.init(frame: CGRectMake(0, 0, arrow1.viewWidth, arrow1.viewWidth + 20))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        var imageName: String
        if type == .Green {
            arrow1.center = CGPointMake(CGRectGetMidX(self.bounds), self.viewHeight - CGRectGetMidY(arrow1.bounds))
            arrow2.center = CGPointMake(arrow1.center.x, arrow1.center.y - 10)
            arrow3.center = CGPointMake(arrow2.center.x, arrow2.center.y - 10)
        } else {
            arrow1.image = UIImage(named: "arrowRed.png")
            arrow2.image = UIImage(named: "arrowRed.png")
            arrow3.image = UIImage(named: "arrowRed.png")
            arrow1.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(arrow1.bounds))
            arrow2.center = CGPointMake(arrow1.center.x, arrow1.center.y + 10)
            arrow3.center = CGPointMake(arrow2.center.x, arrow2.center.y + 10)
        }
        
        self.addSubview(arrow1)
        self.addSubview(arrow2)
        self.addSubview(arrow3)
        
        arrow1.alpha = low
        arrow2.alpha = low
        arrow3.alpha = low
        
        animateFirst()
    }
    
    func animateFirst() {
        UIView.animateWithDuration(inDur, delay: 0.0, options: (.CurveEaseIn), animations: {
            self.arrow1.alpha = self.high
            }, completion: {done in
                UIView.animateWithDuration(self.outDur, delay: 0.0, options: (.CurveEaseOut), animations: {
                    self.arrow1.alpha = self.low
                    }, completion: {done in
                        self.animateSecond()
                })
        })
    }
    
    func animateSecond() {
        UIView.animateWithDuration(inDur, delay: 0.0, options: (.CurveEaseIn), animations: {
            self.arrow2.alpha = self.high
            }, completion: {done in
                UIView.animateWithDuration(self.outDur, delay: 0.0, options: (.CurveEaseOut), animations: {
                    self.arrow2.alpha = self.low
                    }, completion: {done in
                        self.animateThird()
                })
        })
    }
    
    func animateThird() {
        UIView.animateWithDuration(inDur, delay: 0.0, options: (.CurveEaseIn), animations: {
            self.arrow3.alpha = self.high
            }, completion: {done in
                UIView.animateWithDuration(self.outDur, delay: 0.0, options: (.CurveEaseOut), animations: {
                    self.arrow3.alpha = self.low
                    }, completion: {done in
                        self.animateFirst()
                })
        })
    }
    
}



