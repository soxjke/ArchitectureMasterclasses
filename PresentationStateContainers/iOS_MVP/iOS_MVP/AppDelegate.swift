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
    var isStorybook: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        start(isStorybook: isStorybook)
        
        return true
    }
    
    func toggleStroybook() {
        isStorybook = !isStorybook
        start(isStorybook: isStorybook)
    }
    
    private func start(isStorybook: Bool) {
        window = UIWindow()
        window?.rootViewController = isStorybook ? startStorybook() : startApp()
        window?.makeKeyAndVisible()
    }
    
    private func startApp() -> UIViewController {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LoginViewController
        let loginPresenter = LoginPresenter(controller: loginViewController)
        loginViewController.retainedObject = loginPresenter
        return loginViewController
    }
    
    private func startStorybook() -> UIViewController {
        return UINavigationController(rootViewController: StorybookViewController(style: .grouped))
    }
}

extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            (UIApplication.shared.delegate as! AppDelegate).toggleStroybook()
        }
    }
}
