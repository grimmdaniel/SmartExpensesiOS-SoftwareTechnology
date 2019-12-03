//
//  ProfileSettingsCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ProfileSettingsCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showProfileSettingsScreen()
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
    
    private func showProfileSettingsScreen() {
        
        let profileSettingsViewController = ProfileSettingsViewController.instantiate()
        
        profileSettingsViewController.logOutClosure = {
            NotificationCenter.default.post(name: NSNotification.Name(NotificationConstants.logOutNotification), object: nil)
        }
        
        profileSettingsViewController.colorPickerClosure = { [weak self] in
            let colorPickerVC = ColorPickerViewController.instantiate()
            
            colorPickerVC.numberOfLatestSpendings = profileSettingsViewController.currentNumberOfLatestSpendings
            
            colorPickerVC.colorSelectedClosure = { [weak self] (colorCode) in
                profileSettingsViewController.currentColorCode = colorCode
                self?.navigationController.popViewController(animated: true)
            }
            
            self?.navigationController.pushViewController(colorPickerVC, animated: true)
        }
        
        profileSettingsViewController.numberOfLatestSpendingsClosure = { [weak self] (currentNumber) in
            let numberSelectionVC = NumberOfVisibleSpendingsVC.instantiate()
            numberSelectionVC.selectedColor = profileSettingsViewController.currentColorCode
            numberSelectionVC.currentlySelectedIndex = currentNumber - 5
            numberSelectionVC.numberSelectedClosure = { [weak self] (number) in
                profileSettingsViewController.currentNumberOfLatestSpendings = number
                self?.navigationController.popViewController(animated: true)
            }
            
            self?.navigationController.pushViewController(numberSelectionVC, animated: true)
        }
        
        profileSettingsViewController.service = LogoutService()
        profileSettingsViewController.profileService = ProfileService()
        navigationController.pushViewController(profileSettingsViewController, animated: true)
    }
}
