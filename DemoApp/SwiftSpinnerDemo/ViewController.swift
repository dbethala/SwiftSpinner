//
// Copyright (c) 2015 Marin Todorov, Underplot ltd.
// This code is distributed under the terms and conditions of the MIT license.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

//Hurricane Irene (default) image path -DB
var absolutePathToImage: String = "/Users/davidbethala/Documents/Xcode Projects/SwiftSpinner/DemoApp/SwiftSpinnerDemo/Images.xcassets/Hurricane_Irene.imageset/Hurricane_Irene.jpg"


//Setting the image from file path -DB
var baseImage: UIImage = UIImage(contentsOfFile: absolutePathToImage)!

import UIKit
import SwiftSpinner

class ViewController: UIViewController {
    
    func delay(#seconds: Double, completion:()->()) {
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
    func setBlurBackground(imageToSet: UIImage) {
        let colorPicker = DBImageColorPicker()
        colorPicker.image = imageToSet
        colorPicker.backgroundType = DBImageColorPickerBackgroundType.Default
        SwiftSpinner.setBlurColor(colorPicker.backgroundColor)
    }
    
    //
    // Button to start spinner animation
    //
    @IBAction func startSpinnerAnimation(sender: UIBarButtonItem) {
        self.demoSpinner()
    }
    
    //
    //Function call to color changing method -DB
    //
    @IBAction func setNewblurColor(sender: UIBarButtonItem) {
        self.setBlurBackground(baseImage)
    }
    
    //
    // Make circles into squares
    //
    @IBAction func makeIntoSquareButton(sender: UIBarButtonItem) {
        SwiftSpinner.alterShape()
    }
    
    //
    // Set blur to clear color -DB
    //
    @IBAction func makeBlurClearButton(sender: UIBarButtonItem) {
        SwiftSpinner.makeBlurClear()
    }
    
    
    func demoSpinner() {
        
        delay(seconds: 2.0, completion: {
            //SwiftSpinner.makeTriangles()
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
    }
    
}