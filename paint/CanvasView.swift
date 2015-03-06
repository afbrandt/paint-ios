//
//  CanvasView.swift
//  paint
//
//  Created by Andrew Brandt on 3/4/15.
//  Copyright (c) 2015 dorystudios. All rights reserved.
//

import UIKit

struct Stroke {
    var origin: CGPoint
    var end: CGPoint
    var thickness: CGFloat
    var color: CGColor
}

class CanvasView: UIView {
    var color: UIColor = UIColor.blueColor()
    var thickness: CGFloat = 2.0
    var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
    var currentPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var clearContext: Bool = false
    
    var strokes: [Stroke] = []
    
    init(frame: CGRect, color: UIColor, newPath: Bool) {
        super.init(frame: frame)
        //self.backgroundColor = color
        //self.color = color
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var link = CADisplayLink(target: self, selector: Selector("refreshView"))
        link.frameInterval = 1
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    override func drawRect(rect:CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        for var i = 0; i < strokes.count; i++ {
            var stroke = strokes[i]
            CGContextSetStrokeColorWithColor(context, stroke.color)
            CGContextSetLineWidth(context, stroke.thickness)
            CGContextStrokePath(context)
            CGContextMoveToPoint(context, stroke.origin.x, stroke.origin.y)
            CGContextAddLineToPoint(context, stroke.end.x, stroke.end.y)
        }
        
        // Q&D - This used to draw unjoined circles
        //
        // CGContextAddEllipseInRect(context, rect)
        // CGContextSetFillColor(context, CGColorGetComponents(self.color.CGColor))
        // CGContextFillPath(context)
    }
    
    func refreshView() {
        if clearContext {
            self.strokes.removeAll(keepCapacity: false)
            self.clearContext = false
        }
        self.setNeedsDisplay()
    }
    
    func update(point:CGPoint) {
        self.lastPoint = self.currentPoint
        self.currentPoint = point
        if (self.lastPoint != CGPointZero && self.currentPoint != CGPointZero) {
            var stroke = Stroke(origin: self.lastPoint, end: self.currentPoint, thickness: self.thickness, color: self.color.CGColor)
            self.strokes.append(stroke)
        }
    }
    
}
