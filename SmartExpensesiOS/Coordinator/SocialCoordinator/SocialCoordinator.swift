//
//  SocialCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class SocialCoordianator: Coordinator {
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showSocialScreen()
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, willShow: viewController, animated: animated)
        }
    }
    
    override func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.navigationController(navigationController, didShow: viewController, animated: animated)
        }
    }
    
    private func showSocialScreen() {
        
        let socialViewController = SocialViewController.instantiate()
        socialViewController.viewModel = SocialViewModel()
        socialViewController.service = SocialService()
        navigationController.pushViewController(socialViewController, animated: true)
    }
}
