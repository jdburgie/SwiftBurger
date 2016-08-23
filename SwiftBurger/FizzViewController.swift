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
    
    @IBOutlet var numberString: UITextField!
    @IBOutlet var progressText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberString.text = "0"
    }
    
    func fizzBuzz(number: NSInteger) {
        if number == 0 {
            self.progressText.text = "Either way you look at it, 0! is 1\nYes, really."
        } else {
            self.progressText.text = ""
            for i in 1...number {
                var modThree:NSInteger = 0
                var modFive:NSInteger = 0
                
                let fizzString:NSString = NSString(format: "%d", i)
                
                let hasThree:Bool = fizzString .containsString("3")
                let hasFive:Bool = fizzString .containsString("5")
                
                modThree = i%3
                modFive = i%5
                
                var fizzBuzzMsg:NSString!
                
                if (((modThree == 0) && (modFive == 0)) || (hasThree && hasFive)) {
                    fizzBuzzMsg = "-> BizzBuzz\r"
                } else if (modThree == 0 || hasThree) {
                    fizzBuzzMsg = "-> Bizz\r"
                } else if (modFive == 0 || hasFive) {
                    fizzBuzzMsg = "-> Buzz\r"
                } else {
                    fizzBuzzMsg = NSString(format: "%d\r", i)
                }
                
                self.progressText.text = self.progressText.text.stringByAppendingString(fizzBuzzMsg as String)
            }
        }
        
        if (self.progressText.text == "") {
            self.progressText.text = "Nothing to count."
        }
        
        var endOfTextView:NSRange = NSRangeFromString("0,0")
        endOfTextView.location = progressText.text.characters.count
        endOfTextView.length = 1
        self.progressText .scrollRangeToVisible(endOfTextView)
    }
    
    func removeChildViewController(viewController: UIViewController) {
        viewController .willMoveToParentViewController(nil)
        viewController.view .removeFromSuperview()
        viewController .removeFromParentViewController()
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
            fizzBuzz(number)
        }
    }
}