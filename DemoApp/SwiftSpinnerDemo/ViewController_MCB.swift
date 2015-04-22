//
//  ViewController_MCB.swift
//  SwiftSpinnerDemo
//
//  Created by David Bethala on 4/14/15.
//  Copyright (c) 2015 Underplot ltd. All rights reserved.
//

//Multi-colored balloons iPhone wallpaper -DB
let absolutePathToImage_MCB: String = "/Users/davidbethala/Documents/Xcode Projects/SwiftSpinner/DemoApp/SwiftSpinnerDemo/Images.xcassets/img_00002.imageset/img_00002.jpg"

//Setting the image from file path -DB
var baseImage_MCB: UIImage = UIImage(contentsOfFile: absolutePathToImage_MCB)!

import UIKit
import SwiftSpinner

class ViewController_MCB: ViewController {
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
    @IBAction func startSpinnerAnimation_MCB(sender: UIBarButtonItem) {
        self.demoSpinner()
    }
    
    //
    // Button to change the blur to image color -DB
    //
    @IBAction func changeBlurButton_MCB(sender: UIBarButtonItem) {
        self.setBlurBackground(baseImage_MCB)
    }
    
    //
    // Button to make circles into squares -DB
    //
    @IBAction func makeSquaresButton_MCB(sender: UIBarButtonItem) {
        SwiftSpinner.alterShape()
    }
    
    //
    // Button to revert blur color to clear -DB
    //
    @IBAction func revertBlurButton_MCB(sender: UIBarButtonItem) {
        SwiftSpinner.makeBlurClear()
    }
    
    override func demoSpinner() {
        
        //
        //Function call to color changing method -DB
        //
        //self.setBlurBackground(baseImage_MCB)
        
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
            SwiftSpinner.show("Failed to connect, waiting...", animated: false)
        })
        
        delay(seconds: 12.0, completion: {
            SwiftSpinner.show("Connecting...")
        })
        
        delay(seconds: 13.0, completion: {
            SwiftSpinner.showWithProgress("Connected", progress: "100%", animated: false)
        })
        
        delay(seconds: 14.0, completion: {
            SwiftSpinner.hide()
        })
        /*
        delay(seconds: 14.0, completion: {
        SwiftSpinner.setDefaultTitleFont(UIFont(name: "Chalkduster", size: 18.0))
        //SwiftSpinner.alterShape()   //Function call to change the outer circle to a square -DB
        SwiftSpinner.show("Retrying to authenticate")
        })
        
        delay(seconds: 16.0, completion: {
        SwiftSpinner.show("50%")
        })
        
        delay(seconds: 18.0, completion: {
        SwiftSpinner.showWithProgress("Validating", progress: "75%")
        //SwiftSpinner.revertShapes()
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