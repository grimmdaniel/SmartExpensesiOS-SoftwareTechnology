//
//  WelcomeCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation
import UIKit

class WelcomeCoordiator: Coordinator {
    
//    private let navigationController = UINavigationController()
    private let welcomeVC = WelcomeViewController.instantiate()
    
    var rootViewController: UIViewController {
        return welcomeVC
    }
    
    override func start() {
        // Set Navigation Controller Delegate
//        navigationController.delegate = self
        showWelcomeScreen()
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
    
    private func showWelcomeScreen() {
        
        welcomeVC.signInClosure = { [weak self] in
            let signInVC = SignInViewController.instantiate()
            signInVC.modalPresentationStyle = .fullScreen
            
            signInVC.closeScreenClosure = { [weak self] in
                self?.welcomeVC.dismiss(animated: true)
            }
            
            self?.welcomeVC.present(signInVC, animated: true)
        }
        
        welcomeVC.signUpClosure = { [weak self] in
            let signUpVC = SignUpViewController.instantiate()
            signUpVC.modalPresentationStyle = .fullScreen
            
            signUpVC.closeScreenClosure = { [weak self] in
                self?.welcomeVC.dismiss(animated: true)
            }
            
            self?.welcomeVC.present(signUpVC, animated: true)
        }
//        welcomeVC.viewModel = smth
//        let welcomeVC = WelcomeViewController.instantiate()
//
//        //Viewmodel etc
//
//        navigationController.pushViewController(welcomeVC, animated: true)
    }
}
