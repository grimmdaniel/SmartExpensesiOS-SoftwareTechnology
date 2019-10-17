//
//  TabbarController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = ColorTheme.primaryColor
        tabBar.unselectedItemTintColor = ColorTheme.secondaryColor
    }
}
