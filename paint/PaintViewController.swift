//
//  PaintViewController.swift
//  paint
//
//  Created by Andrew Brandt on 3/4/15.
//  Copyright (c) 2015 dorystudios. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController {
    
    @IBOutlet weak var canvas: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        var touch = recognizer.locationInView(canvas)
        println("x: \(touch.x) y: \(touch.y)")
        var panRect = CGRectMake(touch.x, touch.y, 10, 10)
        var paint = CanvasView(frame:panRect, color:UIColor.redColor())
        canvas.addSubview(paint)
        
    }
}
