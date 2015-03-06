//
//  PaintViewController.swift
//  paint
//
//  Created by Andrew Brandt on 3/4/15.
//  Copyright (c) 2015 dorystudios. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, FCColorPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var canvas: UIView!
    var currentColor: UIColor = UIColor.redColor()
    var currentSize: CGFloat = 5.0
    let brushSizes = ["Small", "Medium", "Large"]
    var picker: UIPickerView!
    var strokes: [CGPoint] = []
    
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
        
        if recognizer.state == .Began {
            self.paint(touch, end:true)
        } else {
            self.paint(touch, end:false)
        }
        
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        //get location of touch
        var touch = recognizer.locationInView(canvas)
        //println("x: \(touch.x) y: \(touch.y)")
        self.paint(touch, end: true)
    }
    
    func paint(loc: CGPoint, end: Bool) {
        //make CGRect for CanvasView frame
        var panRect = CGRectMake(loc.x - self.currentSize, loc.y - self.currentSize, 2*self.currentSize, 2*self.currentSize)
        var paint = CanvasView(frame:panRect, color:self.currentColor, newPath: end)
        //add to view
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
        var picker = FCColorPickerViewController.colorPicker()
        picker.color = self.currentColor
        picker.delegate = self
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func setSize() {
        canvas.bringSubviewToFront(self.picker)
        self.picker.hidden = false
    }
    
    //pragma MARK: - FCColorPickerViewControllerDelegate methods
    
    func colorPickerViewController(colorPicker: FCColorPickerViewController!, didSelectColor color: UIColor!) {
        self.currentColor = color
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
                self.currentSize = 5.0
                break;
            case 1:
                self.currentSize = 12.0
                break;
            case 2:
                self.currentSize = 20.0
                break;
            default:
                break;
        }
        //this breaks, no stack trace?
        //pickerView.removeFromSuperview()
    }
}
