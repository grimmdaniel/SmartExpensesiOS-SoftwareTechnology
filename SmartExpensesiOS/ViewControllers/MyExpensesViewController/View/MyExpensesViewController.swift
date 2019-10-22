//
//  MyExpensesViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class MyExpensesViewController: UIViewController, StoryboardAble {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "MyExpenses"
        tabBarItem.image = UIImage(named: "tabbar_1.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}