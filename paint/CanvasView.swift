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
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.color = color
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect:CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(context, rect)
        CGContextSetFillColor(context, CGColorGetComponents(self.color.CGColor))
        CGContextFillPath(context)
    }
}
