//
//  FactorialViewController.swift
//  SwiftBurger
//
//  Created by jdburgie on 8/22/16.
//  Copyright © 2016 Three Oak Wood. All rights reserved.
//

import Foundation
import UIKit

class FactorialViewController: UIViewController {
    
    @IBOutlet var numberString: UITextField!
    @IBOutlet var answer: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberString.text = "0"
        self.answer.text = ""
    }
    
    func factorial(number: NSInteger) {
        if number == 0 {
            self.answer.text = "Either way you look at it 0! is 1\nYes, really."
        } else {
            var factorial:NSInteger = 1
            
            var factorialMsg:NSString!
            if (number > 20) {
                factorialMsg = NSString(format: " (Factorial of %ld is too big for long int)\n", number)
                self.answer.text = self.answer.text!.stringByAppendingString(factorialMsg as String)
            } else {
                for j in number.stride(through: 1, by: -1)  {
                    factorial = factorial * j
                }
                
                factorialMsg = NSString(format: "%d factorial by iteration %d,\n", number, factorial)
                
                self.answer.text = self.answer.text!.stringByAppendingString(factorialMsg as String)
                
                factorial = self.recurseFactorial(number)
                
                factorialMsg = NSString(format: " by recursion %d\n\n", factorial)
                
                self.answer.text = self.answer.text!.stringByAppendingString(factorialMsg as String)
            }
        }
        
        var endOfTextView:NSRange = NSRangeFromString("0,0")
        endOfTextView.location = self.answer.text!.characters.count
        endOfTextView.length = 1
        self.answer.scrollRangeToVisible(endOfTextView)
    }
    
    func removeChildViewController(viewController: UIViewController) {
        viewController .willMoveToParentViewController(nil)
        viewController.view .removeFromSuperview()
        viewController .removeFromParentViewController()
    }
    
    func recurseFactorial(number: NSInteger) -> NSInteger {
        if (number == 0 || number == 1) {
            return 1
        }
        
        var mutableNumber = number
        
        mutableNumber *= recurseFactorial((mutableNumber - 1))
        
        return mutableNumber
    }
    
    @IBAction func tappedRunIt(button: UIButton) {
        numberString.resignFirstResponder()
        
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
            factorial(number)
        }
    }
}