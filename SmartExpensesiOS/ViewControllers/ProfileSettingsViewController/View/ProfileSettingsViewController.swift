//
//  ProfileSettingsViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController, StoryboardAble {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "My Profile"
        tabBarItem = UITabBarItem(title: "My Profile", image: UIImage(named: "tabbar_4.png"), tag: 4)
    }
    
    var logOutClosure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
    }
    
    @objc func logOut() {
        LoginService.logOutUser()
        logOutClosure?()
    }
}
