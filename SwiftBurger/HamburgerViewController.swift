//
//  HamburgerViewController.swift
//  SwiftBurger
//
//  Created by jdburgie on 11/18/15.
//  Copyright © 2015 Three Oak Wood. All rights reserved.
//

import Foundation
import UIKit

class HamburgerViewController: UIViewController {
    // MARK: Properties
    
    var backViewController: UIViewController = UIViewController()
    var vanityViewController: UIViewController = UIViewController()
    var frontViewController: UIViewController = UIViewController()
    
    var vanityViewInFrame: CGRect = CGRectZero
    var vanityViewOutFrame: CGRect = CGRectZero
    
    var sideViewWidthPercent: CGFloat = 0.5
    
    var right: Bool = false
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vanityFrame: CGRect = view.frame
        
        let vanityWidth: CGFloat = view.frame.size.width * 0.05
        
        vanityFrame.size.width = vanityWidth
        vanityFrame.origin.x = view.frame.size.width
        vanityViewOutFrame = vanityFrame
        
        vanityFrame.origin.x = view.frame.size.width - vanityWidth + 1
        vanityViewInFrame = vanityFrame
        
        vanityViewController.view.frame = vanityViewInFrame
        
        addChildVC(vanityViewController)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        var vanityFrame: CGRect = vanityViewController.view.frame
        let vanityWidth: CGFloat = view.frame.size.width * 0.05
        
        vanityFrame.size.width = vanityWidth
        vanityFrame.origin.x = view.frame.size.width
        vanityViewOutFrame = vanityFrame
        
        vanityFrame.origin.x = view.frame.size.width - vanityWidth + 1.0
        vanityViewInFrame = vanityFrame
    }
    
    // MARK: Convenience
    
    func addChildVC(viewController: UIViewController) {
        var index: NSInteger = 0
        
        let subViews: NSArray = view .subviews
        
        if (backViewController.self == viewController.self) {
            index = 0
        } else if (vanityViewController.self == viewController.self) {
            index = 1
        } else if (frontViewController.self == viewController.self) {
            index = subViews.count + 1
        }
        
        view .insertSubview(viewController.view, atIndex: index)
        
        viewController .didMoveToParentViewController(self)
    }
    
    func removeChildViewController(viewController: UIViewController) {
        viewController .willMoveToParentViewController(nil)
        viewController.view .removeFromSuperview()
        viewController .removeFromParentViewController()
    }
    
    func presentFrontViewController(frontViewController: UIViewController) {
        vanityViewController.view.frame = vanityViewOutFrame;
        
        UIView .animateWithDuration(0.25, animations: { () -> Void in
            var frame: CGRect = frontViewController.view.frame
            
            // Move frontViewController view off the screen to the right
            frame.origin.x = self.view.frame.size.width
            frontViewController.view.frame = frame
            }) { (Bool finished) -> Void in
                self.swapFrontChildViewController(frontViewController, newViewController: frontViewController)
                self.showHideSideView()
        }
    }
    
    func swapFrontChildViewController(oldViewController: UIViewController, newViewController: UIViewController) {
        let frame: CGRect = frontViewController.view.frame
        self .removeChildViewController(oldViewController)
        
        frontViewController = newViewController
        frontViewController.view.frame = frame
        
        vanityViewController.view .backgroundColor = frontViewController.view.backgroundColor
        
        addChildVC(frontViewController)
    }
    
    func showHideSideView() {
        UIView .animateWithDuration(0.75, delay: 0.01, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: UIViewAnimationOptions .CurveEaseInOut, animations: { () -> Void in
            self.vanityViewController.view.frame = self.vanityViewInFrame
            var frame: CGRect = self.view.frame
            
            if (self.right) {
                frame.origin.x = 0.0
            } else {
                frame.origin.x = frame.size.width * self.sideViewWidthPercent
            }
            
            })
            { (Bool finished) -> Void in }
        
        right = !right;
    }
    
    @IBAction func tappedHamburger() {
        showHideSideView()
    }
}
