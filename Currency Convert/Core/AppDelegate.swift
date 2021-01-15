//
//  AppDelegate.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: CurrenciesRouter.createModule())
        
        return true
    }
}

