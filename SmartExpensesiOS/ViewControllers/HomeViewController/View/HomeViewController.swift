//
//  HomeViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardAble {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewExpense))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "Home"
        tabBarItem.image = UIImage(named: "tabbar_0.png")
    }
    
    @objc func createNewExpense() {
        print("Creating new expense...")
    }
}