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
    private var mainTabCoordinator = MainTabCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(NotificationConstants.signInNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedOut), name: NSNotification.Name(NotificationConstants.logOutNotification), object: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if LoginService.isUserLoggedIn {
            self.window?.rootViewController = self.mainTabCoordinator.rootViewController
            self.mainTabCoordinator.start()
        } else {
            userLoggedOut()
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    @objc func userLoggedIn() {
        self.mainTabCoordinator = MainTabCoordinator()
        self.window?.rootViewController = self.mainTabCoordinator.rootViewController
        self.mainTabCoordinator.start()
    }
    
    @objc func userLoggedOut() {
        self.welcomeCoordiator = WelcomeCoordiator()
        self.window?.rootViewController = self.welcomeCoordiator.rootViewController
        self.welcomeCoordiator.start()
    }
}
