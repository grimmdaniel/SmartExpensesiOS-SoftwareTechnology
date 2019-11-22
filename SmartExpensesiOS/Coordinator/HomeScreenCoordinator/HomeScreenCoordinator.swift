//
//  HomeScreenCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeScreenCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showHomeScreen()
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
    
    private func showHomeScreen() {
        
        let homeViewController = HomeViewController.instantiate()
        
        homeViewController.addNewExpenseClosure = {
            let addNewExpensesVC = AddNewExpenseViewController.instantiate()
            addNewExpensesVC.locationManager = LocationManager()
            addNewExpensesVC.viewModel = AddNewExpenseViewModel()
            addNewExpensesVC.service = AddNewExpenseService()
            addNewExpensesVC.modalPresentationStyle = .overFullScreen
            
            addNewExpensesVC.closeScreenClosure = {
                homeViewController.dismiss(animated: true)
            }
            
            addNewExpensesVC.newExpenseCreated = { (expense) in
                homeViewController.dismiss(animated: true)
                homeViewController.viewModel.addNewExpense(expense: expense)
                homeViewController.mainTableView.reloadData()
            }
            
            homeViewController.present(addNewExpensesVC, animated: true, completion: nil)
        }
        
        homeViewController.viewModel = HomeViewModel()
        homeViewController.service = HomeViewControllerService()
        
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
