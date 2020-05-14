//
//  AppDelegate.swift
//  iOS_MVP
//
//  Created by Petro Korienev on 5/14/20.
//  Copyright © 2020 Petro Korienev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let loginPresenter = LoginPresenter(controller: loginViewController)
        loginViewController.retainedObject = loginPresenter
        
        window = UIWindow()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

