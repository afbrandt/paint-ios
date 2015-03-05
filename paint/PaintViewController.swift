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
    var currentColor: UIColor = UIColor.redColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup toolbar buttons
        var clearButton = UIBarButtonItem(title:"Clear", style: .Bordered, target: self, action: Selector("clearCanvas"))
        clearButton.width = 80
        
        var selectColorButton = UIBarButtonItem(title:"Choose Color", style: .Bordered, target: self, action: Selector("setColor"))
        selectColorButton.width = 100
        
        var sizeButton = UIBarButtonItem(title:"Brush Size", style: .Bordered, target: self, action: Selector("setSize"))
        sizeButton.width = 100
        
        var toolbarItems = [clearButton, selectColorButton, sizeButton]
        
        self.toolbarItems = toolbarItems
        self.navigationController?.toolbarHidden = false
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        //get location of touch
        var touch = recognizer.locationInView(canvas)
        //println("x: \(touch.x) y: \(touch.y)")
        
        //make CGRect for CanvasView frame
        var panRect = CGRectMake(touch.x, touch.y, 10, 10)
        var paint = CanvasView(frame:panRect, color:UIColor.redColor())
        canvas.addSubview(paint)
        
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        //get location of touch
        var touch = recognizer.locationInView(canvas)
        //println("x: \(touch.x) y: \(touch.y)")
        
        //make CGRect for CanvasView frame
        var panRect = CGRectMake(touch.x, touch.y, 10, 10)
        var paint = CanvasView(frame:panRect, color:UIColor.redColor())
        canvas.addSubview(paint)
        
    }
    
    func clearCanvas() {
        for obj in canvas.subviews {
            if let paint = obj as? CanvasView {
                paint.removeFromSuperview()
            }
        }
    }
    
    func setColor() {
        
    }
    
    func setSize() {
    
    }
}
