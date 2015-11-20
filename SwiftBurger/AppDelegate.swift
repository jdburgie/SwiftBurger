//
//  AppDelegate.swift
//  SwiftBurger
//
//  Created by jdburgie on 11/18/15.
//  Copyright © 2015 Three Oak Wood. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let hamburgerViewController: HamburgerViewController = HamburgerViewController()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        hamburgerViewController.backViewController = storyboard .instantiateViewControllerWithIdentifier("ListViewController")
        hamburgerViewController.frontViewController = storyboard .instantiateViewControllerWithIdentifier("PictureViewController")
        
        hamburgerViewController .addChildVC(hamburgerViewController.backViewController)
        hamburgerViewController .addChildVC(hamburgerViewController.frontViewController)
        
        hamburgerViewController.vanityViewController.view.backgroundColor = hamburgerViewController.frontViewController.view.backgroundColor
        
        hamburgerViewController.backViewController.view.frame = hamburgerViewController.view.frame
        hamburgerViewController.frontViewController.view.frame = hamburgerViewController.view.frame
        
        return true
    }
}

