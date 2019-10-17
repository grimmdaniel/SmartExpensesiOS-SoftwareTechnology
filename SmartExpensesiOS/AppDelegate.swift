//
//  AppDelegate.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 2019. 10. 04..
//  Copyright © 2019. com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let welcomeCoordiator = WelcomeCoordiator()
    private let mainTabCoordinator = MainTabCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        welcomeCoordiator.didFinish = { [weak self] (_) in
            self?.window?.rootViewController = self?.mainTabCoordinator.rootViewController
            self?.mainTabCoordinator.start()
        }
            
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = welcomeCoordiator.rootViewController
        window?.makeKeyAndVisible()
        welcomeCoordiator.start()
        
        return true
    }
}
