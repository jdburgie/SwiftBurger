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
    
    var rowLabels: [String] = [ "Pictures", "Bizz Buzz" ]
    var viewControllerNames: [String] = [ "PictureViewController", "FizzViewController" ]
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hamburgerViewController = self .parentViewController as! HamburgerViewController
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView .registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "myIdent")
        
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
            hamburgerViewController .presentFrontViewController(viewController);
        }

    }
}
