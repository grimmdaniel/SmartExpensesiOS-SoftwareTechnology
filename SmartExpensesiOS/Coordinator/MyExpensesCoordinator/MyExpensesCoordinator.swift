//
//  MyExpensesCoordinator.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class MyExpensesCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override func start() {
        
        navigationController.delegate = self
        showMyExpensesScreen()
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
    
    private func showMyExpensesScreen() {
        
        let myExpensesViewController = MyExpensesViewController.instantiate()
        myExpensesViewController.service = MyExpensensesService()
        myExpensesViewController.viewModel = MyExpensesViewModel()
        
        myExpensesViewController.addNewExpenseClosure = {
            let addNewExpensesVC = AddNewExpenseViewController.instantiate()
            addNewExpensesVC.locationManager = LocationManager()
            addNewExpensesVC.viewModel = AddNewExpenseViewModel()
            addNewExpensesVC.service = AddNewExpenseService()
            addNewExpensesVC.modalPresentationStyle = .overFullScreen
            
            addNewExpensesVC.closeScreenClosure = {
                myExpensesViewController.dismiss(animated: true)
            }
            
            addNewExpensesVC.newExpenseCreated = { (expense) in
                myExpensesViewController.dismiss(animated: true)
                myExpensesViewController.newExpenseAdded(expense: expense)
            }
            
            myExpensesViewController.present(addNewExpensesVC, animated: true, completion: nil)
        }
        
        navigationController.pushViewController(myExpensesViewController, animated: true)
    }
}
