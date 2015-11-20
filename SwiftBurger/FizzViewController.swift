//
//  FizzViewController.swift
//  SwiftBurger
//
//  Created by jdburgie on 11/18/15.
//  Copyright © 2015 Three Oak Wood. All rights reserved.
//

import Foundation
import UIKit

class FizzViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet var numberString: UITextField!
    @IBOutlet var progressText: UITextView!
    
    // MARK: Convenience
    
    func fizzBuzzFactorial(number: NSInteger) {
        
    }
    
    func removeChildViewController(viewController: UIViewController) {
        viewController .willMoveToParentViewController(nil)
        viewController.view .removeFromSuperview()
        viewController .removeFromParentViewController()
    }
    
    func recurseFactorial(var number: NSInteger) -> NSInteger {
        if (number == 0 || number == 1) {
            return 1
        }
        
        number *= recurseFactorial((number - 1))
        
        return number
    }
    
    @IBAction func tappedRunIt(button: UIButton) {
        numberString .resignFirstResponder()

        let number: NSInteger = NSInteger(numberString.text!)!
        var alertTitle: NSString
        var alertMsg: NSString
        
        if ((number > 100) || (number < 0)) {
            alertTitle = number < 0 ? "Too Negative" : "Too Big"
            alertMsg = number < 0 ? "Enter a number ≥ 0" : "Enter a number ≤ 100"
            
            let alert: UIAlertController = UIAlertController(title: alertTitle as String, message: alertMsg as String, preferredStyle: UIAlertControllerStyle .Alert)

            let action: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle .Cancel) { (UIAlertAction) -> Void in
            }
            
            alert .addAction(action)
            
            self .presentViewController(alert, animated: true, completion: nil )
        } else {
            fizzBuzzFactorial(number)
        }
    }
}