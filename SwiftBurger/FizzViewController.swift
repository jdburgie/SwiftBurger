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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberString.text = "0"
    }
    
    // MARK: Convenience
    
    func fizzBuzzFactorial(number: NSInteger) {
        //        var i:NSInteger
        
        if number == 0 {
            self.progressText.text = "Either way you look at it 0! is 1\nYes, really."
        } else {
            for i in 1...number
            {
                //        for (i = 1; i <= number; i += 1) {
                var modThree:NSInteger = 0
                var modFive:NSInteger = 0
                
                let fizzString:NSString = NSString(format: "%d", i)
                
                let hasThree:Bool = fizzString .containsString("3")
                let hasFive:Bool = fizzString .containsString("5")
                
                var isFizzOrBuzz:Bool = false
                
                modThree = i%3
                modFive = i%5
                
                var fizzBuzzMsg:NSString!
                if (((modThree == 0) && (modFive == 0)) || (hasThree && hasFive)) {
                    fizzBuzzMsg = "-> BizzBuzz"
                    isFizzOrBuzz = true
                } else if (modThree == 0 || hasThree) {
                    fizzBuzzMsg = "-> Bizz"
                    isFizzOrBuzz = true
                } else if (modFive == 0 || hasFive) {
                    fizzBuzzMsg = "-> Buzz"
                    isFizzOrBuzz = true
                } else {
                    fizzBuzzMsg = NSString(format: "%d\n", i)
                    isFizzOrBuzz = false
                }
                
                self.progressText.text = self.progressText.text .stringByAppendingString(fizzBuzzMsg as String)
                
                var factorialFizzBuzz:NSInteger = 1
                
                if (isFizzOrBuzz) {
                    var factorialMsg:NSString!
                    if (i > 20) {
                        factorialMsg = NSString(format: " (Factorial of %ld is too big for long int)\n", i)
                        self.progressText.text = self.progressText.text .stringByAppendingString(factorialMsg as String)
                    } else {
                        //                    var j:NSInteger
                        
                        for j in i.stride(through: 1, by: -1)  {
                            factorialFizzBuzz = factorialFizzBuzz * j
                        }
                        //                    for (j = i; j > 0; j -= 1) {
                        //                    }
                        
                        factorialMsg = NSString(format: "%d factorial by iteration %d, ", i, factorialFizzBuzz)
                        
                        self.progressText.text = self.progressText.text .stringByAppendingString(factorialMsg as String)
                        
                        factorialFizzBuzz = self .recurseFactorial(i)
                        
                        factorialMsg = NSString(format: " by recursion %d\n", factorialFizzBuzz)
                        
                        self.progressText.text = self.progressText.text .stringByAppendingString(factorialMsg as String)
                    }
                }
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
            fizzBuzzFactorial(number)
        }
    }
}