//
// Copyright (c) 2015 Marin Todorov, Underplot ltd.
// This code is distributed under the terms and conditions of the MIT license.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

public class SwiftSpinner: UIView {
    
    // MARK: - Singleton
    
    //
    // Access the singleton instance
    //
    public class var sharedInstance: SwiftSpinner {
        struct Singleton {
            static let instance = SwiftSpinner(frame: CGRect.zeroRect)
        }
        return Singleton.instance
    }
    
    // MARK: - Init
    
    //
    // Custom init to build the spinner UI
    //
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        blurEffect = UIBlurEffect(style: blurEffectStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        addSubview(vibrancyView)
        
        let titleScale: CGFloat = 0.85
        titleLabel.frame.size = CGSize(width: frameSize.width * titleScale, height: frameSize.height * titleScale)
        titleLabel.font = defaultTitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        
        vibrancyView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(vibrancyView)
        
        outerCircleView.frame.size = frameSize
        
        outerCircle.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: frameSize.width, height: frameSize.height)).CGPath
        outerCircle.lineWidth = 8.0
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 0.45
        outerCircle.lineCap = kCALineCapRound
        outerCircle.fillColor = UIColor.clearColor().CGColor
        outerCircle.strokeColor = UIColor.whiteColor().CGColor
        outerCircleView.layer.addSublayer(outerCircle)
        
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(outerCircleView)
        
        innerCircleView.frame.size = frameSize
        
        let innerCirclePadding: CGFloat = 12
        innerCircle.path = UIBezierPath(ovalInRect: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: frameSize.width - 2*innerCirclePadding, height: frameSize.height - 2*innerCirclePadding)).CGPath
        innerCircle.lineWidth = 4.0
        innerCircle.strokeStart = 0.5
        innerCircle.strokeEnd = 0.9
        innerCircle.lineCap = kCALineCapRound
        innerCircle.fillColor = UIColor.clearColor().CGColor
        innerCircle.strokeColor = UIColor.grayColor().CGColor
        innerCircleView.layer.addSublayer(innerCircle)
        
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 1.0
        
        vibrancyView.contentView.addSubview(innerCircleView)
        
    }
    
    // MARK: - Public interface
    
    //
    // Show the spinner activity on screen, if visible only update the title
    //
    public class func show(title: String, animated: Bool = true) {
        
        let window = UIApplication.sharedApplication().windows.first as! UIWindow
        let spinner = SwiftSpinner.sharedInstance
        
        spinner.updateFrame()
        
        if spinner.superview == nil {
            //show the spinner
            spinner.alpha = 0.0
            window.addSubview(spinner)
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 1.0
                }, completion: nil)
        }
        
        spinner.title = title
        spinner.animating = animated
    }
    
    //
    // Show the spinner activity on screen with progress as a percentage, if visible only update the title
    // -DB
    public class func showWithProgress(title: String, progress: String, animated: Bool = true) {
        
        let window = UIApplication.sharedApplication().windows.first as! UIWindow
        let spinner = SwiftSpinner.sharedInstance
        
        spinner.updateFrame()
        
        if spinner.superview == nil {
            //show the spinner
            spinner.alpha = 0.0
            window.addSubview(spinner)
            
            UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.alpha = 1.0
                }, completion: nil)
        }
        
        spinner.title = title
        spinner.progress = progress
        spinner.animating = animated
    }
    
    //
    // Show the spinner activity on screen with custom font, if visible only update the title
    // Note that the custom font will be discarded when hiding the spinner
    // To permanently change the title font, set the defaultTitleFont property
    //
    public class func show(title: String, withFont font: UIFont, animated: Bool = true) {
        let spinner = SwiftSpinner.sharedInstance
        spinner.titleLabel.font = font
        
        show(title, animated: true)
    }
    
    //
    // Hide the spinner
    //
    public class func hide() {
        let spinner = SwiftSpinner.sharedInstance
        
        if spinner.superview == nil {
            return
        }
        
        UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseOut, animations: {
            spinner.alpha = 0.0
            }, completion: {_ in
                spinner.alpha = 1.0
                spinner.removeFromSuperview()
                spinner.titleLabel.font = spinner.defaultTitleFont
                spinner.titleLabel.text = nil
        })
        
        spinner.animating = false
    }
    
    //
    // Set the default title font
    //
    public class func setDefaultTitleFont(font: UIFont?) {
        let spinner = SwiftSpinner.sharedInstance
        spinner.defaultTitleFont = font
        spinner.titleLabel.font = font
    }
    
    //
    // The spinner title
    //
    public var title: String = "" {
        didSet {
            
            let spinner = SwiftSpinner.sharedInstance
            
            UIView.animateWithDuration(0.15, delay: 0.75, options: .CurveEaseOut, animations: {
                spinner.titleLabel.transform = CGAffineTransformMakeScale(0.75, 0.75)
                spinner.titleLabel.alpha = 0.2
                }, completion: {_ in
                    spinner.titleLabel.text = self.title
                    UIView.animateWithDuration(0.35, delay: 0.75, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: nil, animations: {
                        spinner.titleLabel.transform = CGAffineTransformIdentity
                        spinner.titleLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    
    //
    // The spinner's download progress (optional) -DB
    //
    public var progress: String = "" {
        didSet {
            
            let spinner = SwiftSpinner.sharedInstance
            
            UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseOut, animations: {
                spinner.titleLabel.transform = CGAffineTransformMakeScale(0.75, 0.75)
                spinner.titleLabel.alpha = 0.2
                }, completion: {_ in
                    spinner.titleLabel.text = self.progress
                    UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: nil, animations: {
                        spinner.titleLabel.transform = CGAffineTransformIdentity
                        spinner.titleLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    
    //
    // Alter the blur coloring -DB
    //
    public class func setBlurColor(colorToSet: UIColor) {
        let spinner = SwiftSpinner.sharedInstance
        
        spinner.blurView.backgroundColor = colorToSet
    }
    
    //
    // Revert to clear blur -DB
    //
    public class func makeBlurClear() {
        let spinner = SwiftSpinner.sharedInstance
        
        spinner.blurView.backgroundColor = UIColor.clearColor()
    }
    
    //
    //Alter the shape of the spinner to a square -DB
    //
    public class func alterShape() {
        
        
        let spinner = SwiftSpinner.sharedInstance
        
        //Larger square -DB
        let largerRect: CGRect = CGRectMake(0.2, 0.2, spinner.frameSize.width, spinner.frameSize.height)
        let largerCorner: UIRectCorner = UIRectCorner.AllCorners
        let largerSize: CGSize = CGSizeMake(0.4, 0.4)
        spinner.outerCircle.path = UIBezierPath(roundedRect: largerRect, byRoundingCorners: largerCorner, cornerRadii: largerSize).CGPath
        
        
        //Smaller square -DB
        let smallerRect: CGRect = CGRectMake(0.1, 0.1, spinner.frameSize.width, spinner.frameSize.height)
        let smallerCorner: UIRectCorner = UIRectCorner.AllCorners
        let smallerSize: CGSize = CGSize(width: 0.2, height: 0.2)
        spinner.innerCircle.path = UIBezierPath(roundedRect: smallerRect, byRoundingCorners: smallerCorner, cornerRadii: smallerSize).CGPath
    }
    
    public class func makeTriangles() {
        let spinner = SwiftSpinner.sharedInstance
        let triangle: UIBezierPath = UIBezierPath()
        var p1: CGPoint = CGPointMake(spinner.frameSize.width/3+50, spinner.frameSize.height/2+50)
        var p2: CGPoint = CGPointMake(p1.x+150, p1.y+150)
        var p3: CGPoint = CGPointMake(p2.x+150, p1.y+150)
        
        triangle.moveToPoint(p1)
        triangle.addLineToPoint(p2)
        triangle.addLineToPoint(p3)
        
        triangle.closePath()
        
        spinner.outerCircle.path = triangle.CGPath
    }
    
    
    //
    // Revert to circles -DB
    //
    public class func revertShapes() {
        let spinner = SwiftSpinner.sharedInstance
        
        spinner.blurEffect = UIBlurEffect(style: spinner.blurEffectStyle)
        spinner.blurView = UIVisualEffectView(effect: spinner.blurEffect)
        spinner.addSubview(spinner.blurView)
        
        spinner.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: spinner.blurEffect))
        spinner.addSubview(spinner.vibrancyView)
        
        let titleScale: CGFloat = 0.85
        spinner.titleLabel.frame.size = CGSize(width: spinner.frameSize.width * titleScale, height: spinner.frameSize.height * titleScale)
        spinner.titleLabel.font = spinner.defaultTitleFont
        spinner.titleLabel.numberOfLines = 0
        spinner.titleLabel.textAlignment = .Center
        spinner.titleLabel.lineBreakMode = .ByWordWrapping
        spinner.titleLabel.adjustsFontSizeToFitWidth = true
        
        spinner.vibrancyView.contentView.addSubview(spinner.titleLabel)
        spinner.blurView.contentView.addSubview(spinner.vibrancyView)
        
        spinner.outerCircleView.frame.size = spinner.frameSize
        
        spinner.outerCircle.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: spinner.frameSize.width, height: spinner.frameSize.height)).CGPath
        spinner.outerCircle.lineWidth = 8.0
        spinner.outerCircle.strokeStart = 0.0
        spinner.outerCircle.strokeEnd = 0.45
        spinner.outerCircle.lineCap = kCALineCapRound
        spinner.outerCircle.fillColor = UIColor.clearColor().CGColor
        spinner.outerCircle.strokeColor = UIColor.whiteColor().CGColor
        spinner.outerCircleView.layer.addSublayer(spinner.outerCircle)
        
        spinner.outerCircle.strokeStart = 0.0
        spinner.outerCircle.strokeEnd = 1.0
        
        spinner.vibrancyView.contentView.addSubview(spinner.outerCircleView)
        
        spinner.innerCircleView.frame.size = spinner.frameSize
        
        let innerCirclePadding: CGFloat = 12
        spinner.innerCircle.path = UIBezierPath(ovalInRect: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: spinner.frameSize.width - 2*innerCirclePadding, height: spinner.frameSize.height - 2*innerCirclePadding)).CGPath
        spinner.innerCircle.lineWidth = 4.0
        spinner.innerCircle.strokeStart = 0.5
        spinner.innerCircle.strokeEnd = 0.9
        spinner.innerCircle.lineCap = kCALineCapRound
        spinner.innerCircle.fillColor = UIColor.clearColor().CGColor
        spinner.innerCircle.strokeColor = UIColor.grayColor().CGColor
        spinner.innerCircleView.layer.addSublayer(spinner.innerCircle)
        
        spinner.innerCircle.strokeStart = 0.0
        spinner.innerCircle.strokeEnd = 1.0
        
        spinner.vibrancyView.contentView.addSubview(spinner.innerCircleView)
    }
    
    //
    // observe the view frame and update the subviews layout
    //
    public override var frame: CGRect {
        didSet {
            if frame == CGRect.zeroRect {
                return
            }
            blurView.frame = bounds
            vibrancyView.frame = blurView.bounds
            titleLabel.center = vibrancyView.center
            outerCircleView.center = vibrancyView.center
            innerCircleView.center = vibrancyView.center
        }
    }
    
    //
    // Start the spinning animation
    //
    
    public var animating: Bool = false {
        
        willSet (shouldAnimate) {
            if shouldAnimate && !animating {
                spinInner()
                spinOuter()
            }
        }
        
        didSet {
            // update UI
            if animating {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 0.45
                self.innerCircle.strokeStart = 0.5
                self.innerCircle.strokeEnd = 0.9
            } else {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 1.0
                self.innerCircle.strokeStart = 0.0
                self.innerCircle.strokeEnd = 1.0
            }
        }
    }
    
    // MARK: - Private interface
    
    //
    // layout elements
    //
    
    private var blurEffectStyle: UIBlurEffectStyle = .Dark
    private var blurEffect: UIBlurEffect!
    private var blurView: UIVisualEffectView!
    private var vibrancyView: UIVisualEffectView!
    
    lazy var titleLabel = UILabel()
    var defaultTitleFont = UIFont(name: "HelveticaNeue", size: 22.0)
    let frameSize = CGSize(width: 200.0, height: 200.0)
    
    private lazy var outerCircleView = UIView()
    private lazy var innerCircleView = UIView()
    
    private let outerCircle = CAShapeLayer()
    private let innerCircle = CAShapeLayer()
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    private var currentOuterRotation: CGFloat = 0.0
    private var currentInnerRotation: CGFloat = 0.1
    
    private func spinOuter() {
        
        if superview == nil {
            return
        }
        
        let duration = Double(Float(arc4random()) /  Float(UInt32.max)) * 2.0 + 1.5
        let randomRotation = Double(Float(arc4random()) /  Float(UInt32.max)) * M_PI_4 + M_PI_4
        
        //outer circle
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: nil, animations: {
            self.currentOuterRotation -= CGFloat(randomRotation)
            self.outerCircleView.transform = CGAffineTransformMakeRotation(self.currentOuterRotation)
            }, completion: {_ in
                let waitDuration = Double(Float(arc4random()) /  Float(UInt32.max)) * 1.0 + 1.0
                self.delay(seconds: waitDuration, completion: {
                    if self.animating {
                        self.spinOuter()
                    }
                })
        })
    }
    
    private func spinInner() {
        if superview == nil {
            return
        }
        
        //inner circle
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.currentInnerRotation += CGFloat(M_PI_4)
            self.innerCircleView.transform = CGAffineTransformMakeRotation(self.currentInnerRotation)
            }, completion: {_ in
                self.delay(seconds: 0.5, completion: {
                    if self.animating {
                        self.spinInner()
                    }
                })
        })
    }
    
    private func updateFrame() {
        let window = UIApplication.sharedApplication().windows.first as! UIWindow
        SwiftSpinner.sharedInstance.frame = window.frame
    }
    
    // MARK: - Util methods
    
    func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
}
