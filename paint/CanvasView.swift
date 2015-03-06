//
//  CanvasView.swift
//  paint
//
//  Created by Andrew Brandt on 3/4/15.
//  Copyright (c) 2015 dorystudios. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    var color: UIColor!
    var newPath: Bool
    
    init(frame: CGRect, color: UIColor, newPath: Bool) {
        self.newPath = newPath
        super.init(frame: frame)
        self.backgroundColor = color
        self.color = color
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect:CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        // This with draw unjoined circles
        //
        // CGContextAddEllipseInRect(context, rect)
        // CGContextSetFillColor(context, CGColorGetComponents(self.color.CGColor))
        // CGContextFillPath(context)
        //
        
        if (self.newPath) {
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y)
        }
        
        CGContextSetStrokeColorWithColor(context, self.color.CGColor)
        CGContextSetFillColor(context, CGColorGetComponents(self.color.CGColor))
        //CGContextAddRect(context, rect)
        //CGContextAddPath(context, CGPathCreateWithRect(rect, nil))
        CGContextSetLineWidth(context, rect.width)
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y)
        //CGContextDrawPath(context, kCGPathFillStroke)
        //CGContextFillPath(context)
    }
}
