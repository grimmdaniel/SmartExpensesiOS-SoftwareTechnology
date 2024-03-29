//
//  MainTabCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class MainTabCoordinator: Coordinator {
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    private let tabBarController = TabbarController()
    
    override init() {
        super.init()
        
        //child coordinators
        let homeScreenCoordinator = HomeScreenCoordinator()
        let myExpensesCoordinator = MyExpensesCoordinator()
        let socialCoordinator = SocialCoordianator()
//        let currencyRateCoordinator = CurrencyRateCoordinator()
        let profileSettingsCoordinator = ProfileSettingsCoordinator()
        
        tabBarController.viewControllers = [
            homeScreenCoordinator.rootViewController,
            myExpensesCoordinator.rootViewController,
            socialCoordinator.rootViewController,
//            currencyRateCoordinator.rootViewController,
            profileSettingsCoordinator.rootViewController
        ]
        
        childCoordinators.append(homeScreenCoordinator)
        childCoordinators.append(myExpensesCoordinator)
        childCoordinators.append(socialCoordinator)
//        childCoordinators.append(currencyRateCoordinator)
        childCoordinators.append(profileSettingsCoordinator)
    }
    
    override func start() {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.start()
        }
    }
}
