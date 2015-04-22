//
//  ViewController_DC.swift
//  SwiftSpinnerDemo
//
//  Created by David Bethala on 4/14/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

import UIKit
import SwiftSpinner

//Dual-colored iPhone wallpaper -DB
let absolutePathToImage_DC: String = "/Users/davidbethala/Documents/Xcode Projects/SwiftSpinner/DemoApp/SwiftSpinnerDemo/Images.xcassets/img_00010.imageset/img_00010.jpg"

//Setting the image from file path -DB
var baseImage_DC: UIImage = UIImage(contentsOfFile: absolutePathToImage_DC)!

class ViewController_DC: ViewController {
    
    override func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //
    //Function to set new blur background
    // -DB
    override func setBlurBackground(imageToSet: UIImage) {
        let colorPicker = DBImageColorPicker()
        colorPicker.image = imageToSet
        colorPicker.backgroundType = DBImageColorPickerBackgroundType.Default
        SwiftSpinner.setBlurColor(colorPicker.backgroundColor)
    }
    
    //
    // Button to start spinner animation -DB
    //
    @IBAction func startSpinnerAnimation_DC(sender: UIBarButtonItem) {
        self.demoSpinner()
    }
    
    //
    // Button to set blur color to image color -DB
    //
    @IBAction func setBlurColor_DC(sender: UIBarButtonItem) {
        self.setBlurBackground(baseImage_DC)
    }
    
    //
    // Button to transform circles to squares -DB
    //
    @IBAction func makeSquares_DC(sender: UIBarButtonItem) {
        SwiftSpinner.alterShape()
    }
    
    //
    //Button to revert blur to clear color -DB
    //
    @IBAction func makeBlurClearButton_DC(sender: UIBarButtonItem) {
        SwiftSpinner.makeBlurClear()
    }
    
    override func demoSpinner() {
        
        //
        //Function call to color changing method -DB
        //
        //self.setBlurBackground(baseImage_DC)
        
        delay(seconds: 2.0, completion: {
            SwiftSpinner.showWithProgress("Connecting \nto satellite...", progress: "0%")
        })
        
        delay(seconds: 4.0, completion: {
            SwiftSpinner.showWithProgress("Authenticating user account", progress: "12%")
        })
        
        delay(seconds: 6.0, completion: {
            SwiftSpinner.showWithProgress("Authenticating user account", progress: "25%")
        })
        
        delay(seconds: 10.0, completion: {
            SwiftSpinner.show("Connecting...", animated: false)
        })
        
        delay(seconds: 12.0, completion: {
            SwiftSpinner.showWithProgress("Connected", progress: "100%", animated: false )
        })
        
        delay(seconds: 13.0, completion: {
            SwiftSpinner.hide()
        })
        /*
        delay(seconds: 14.0, completion: {
        SwiftSpinner.setDefaultTitleFont(UIFont(name: "Chalkduster", size: 18.0))
        SwiftSpinner.show("Retrying to authenticate")
        })
        
        delay(seconds: 16.0, completion: {
        SwiftSpinner.show("50%")
        //SwiftSpinner.alterShape()   //Function call to change the outer circle to a square -DB
        })
        
        delay(seconds: 18.0, completion: {
        SwiftSpinner.showWithProgress("Validating", progress: "75%")
        })
        
        delay(seconds: 21.0, completion: {
        SwiftSpinner.showWithProgress("Connecting...", progress: "99%")
        })
        
        delay(seconds: 22.0, completion: {
        SwiftSpinner.showWithProgress("Connected", progress: "100%", animated: false)
        })
        
        delay(seconds: 23.0, completion: {
        SwiftSpinner.show("100%", animated: false)
        })
        
        delay(seconds: 24.0, completion: {
        SwiftSpinner.hide()
        })
        
        delay(seconds: 28.0, completion: {
        })
        */
    }
}