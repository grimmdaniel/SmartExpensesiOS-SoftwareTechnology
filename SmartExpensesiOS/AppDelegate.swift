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
    
    private var welcomeCoordiator: WelcomeCoordiator!
    private var mainTabCoordinator: MainTabCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(NotificationConstants.signInNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedOut), name: NSNotification.Name(NotificationConstants.logOutNotification), object: nil)
        
        userLoggedOut()
        return true
    }
    
    @objc func userLoggedIn() {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.mainTabCoordinator = MainTabCoordinator()
        self.window?.rootViewController = self.mainTabCoordinator.rootViewController
        window?.makeKeyAndVisible()
        self.mainTabCoordinator.start()
    }
    
    @objc func userLoggedOut() {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.welcomeCoordiator = WelcomeCoordiator()
        self.window?.rootViewController = self.welcomeCoordiator.rootViewController
        window?.makeKeyAndVisible()
        self.welcomeCoordiator.start()
    }
}
