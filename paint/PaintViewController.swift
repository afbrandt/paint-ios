//
//  PaintViewController.swift
//  paint
//
//  Created by Andrew Brandt on 3/4/15.
//  Copyright (c) 2015 dorystudios. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, FCColorPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var canvas: CanvasView!
    var currentColor: UIColor = UIColor.blueColor()
    var currentSize: CGFloat = 5.0
    let brushSizes = ["Small", "Medium", "Large"]
    var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup toolbar buttons
        var clearButton = UIBarButtonItem(title:"Clear", style: .Bordered, target: self, action: Selector("clearCanvas"))
        clearButton.width = 70
        
        var selectColorButton = UIBarButtonItem(title:"Choose Color", style: .Bordered, target: self, action: Selector("setColor"))
        selectColorButton.width = 100
        
        var sizeButton = UIBarButtonItem(title:"Brush Size", style: .Bordered, target: self, action: Selector("setSize"))
        sizeButton.width = 100
        
        var toolbarItems = [clearButton, selectColorButton, sizeButton]
        
        self.toolbarItems = toolbarItems
        self.navigationController?.toolbarHidden = false
        
        //init brush size picker
        var width = UIScreen.mainScreen().bounds.width
        var height = UIScreen.mainScreen().bounds.height
        var pickerHeight = height - 250
        var pickerWidth = width * 3/4
        var x = width/2 - pickerWidth/2
        
        self.picker = UIPickerView(frame: CGRectMake(x, pickerHeight, pickerWidth, 200))
        self.picker.delegate = self
        self.picker.showsSelectionIndicator = true
        self.picker.backgroundColor = UIColor.lightGrayColor()
        self.picker.hidden = true
        canvas.addSubview(self.picker)
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        //get location of touch
        var touch = recognizer.locationInView(canvas)
        //println("x: \(touch.x) y: \(touch.y)")
        
        switch (recognizer.state) {
            case .Ended:
                self.paint(touch, end:true)
                break;
            case .Began:
                self.paint(touch, end:true)
                break;
            default:
                self.paint(touch, end:false)
                break;
        }
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        //get location of touch
        var touch = recognizer.locationInView(canvas)
        //println("x: \(touch.x) y: \(touch.y)")
        self.paint(touch, end: true)
        //hacky way to draw tap and make sure its isolated
        self.paint(CGPointMake(touch.x, touch.y+1), end:false)
        self.paint(CGPointZero, end: false)
    }
    
    func paint(loc: CGPoint, end: Bool) {
        //make CGRect for CanvasView frame
        //var panRect = CGRectMake(loc.x - self.currentSize, loc.y - self.currentSize, 2*self.currentSize, 2*self.currentSize)
        //var paint = CanvasView(frame:panRect, color:self.currentColor, newPath: end)
        //add to view
        //canvas.addSubview(paint)
        
        if end {
            canvas.update(CGPoint(x:0,y:0))
        }
        //println("x: \(loc.x) y: \(loc.y)")
        canvas.update(loc)
    }
    
    func clearCanvas() {
//        for obj in canvas.subviews {
//            if let paint = obj as? CanvasView {
//                paint.removeFromSuperview()
//            }
//        }
        canvas.clearContext = true
    }
    
    func setColor() {
        var picker = FCColorPickerViewController.colorPicker()
        picker.color = self.currentColor
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func setSize() {        
        if let items = self.toolbarItems as? [UIBarButtonItem] {
                items[2].title = self.picker.hidden ? "Dismiss" : "Brush Size"
        }
        self.picker.hidden = !self.picker.hidden
    }
    
    //pragma MARK: - FCColorPickerViewControllerDelegate methods
    
    func colorPickerViewController(colorPicker: FCColorPickerViewController!, didSelectColor color: UIColor!) {
        self.currentColor = color
        canvas.color = self.currentColor
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func colorPickerViewControllerDidCancel(colorPicker: FCColorPickerViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //pragma MARK: - UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.brushSizes.count
    }
    
    //pragma MARK: - UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.brushSizes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (row) {
            case 0:
                canvas.thickness = 2.0
                break;
            case 1:
                canvas.thickness = 3.5
                break;
            case 2:
                canvas.thickness = 6.0
                break;
            default:
                break;
        }
        //this breaks, no stack trace?
        //pickerView.removeFromSuperview()
    }
}
