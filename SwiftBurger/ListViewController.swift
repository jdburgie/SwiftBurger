//
//  ListViewController.swift
//  SwiftBurger
//
//  Created by jdburgie on 11/19/15.
//  Copyright © 2015 Three Oak Wood. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    // MARK: Properties

    var hamburgerViewController: HamburgerViewController!
    
    var rowLabels: [String] = [ "Pictures", "Bizz Buzz", "Factorial" ]
    var viewControllerNames: [String] = [ "PictureViewController", "FizzViewController", "FactorialViewController" ]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        tableView .registerClass(UITableViewCell.self, forCellReuseIdentifier: "myIdent")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowLabels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView .dequeueReusableCellWithIdentifier("myIdent")!;
        
        cell .textLabel! .text = rowLabels [ indexPath .row ]
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row: NSInteger = indexPath .row
        
        let storyboard: UIStoryboard = self .storyboard!
        
        let viewController: UIViewController = storyboard .instantiateViewControllerWithIdentifier(viewControllerNames[row])
        
        if (hamburgerViewController.frontViewController.self == viewController.self) {
            hamburgerViewController .showHideSideView()
        } else {
            hamburgerViewController.presentFrontViewController(viewController);
        }

    }
}
