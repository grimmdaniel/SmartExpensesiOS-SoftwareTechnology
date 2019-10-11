//
//  WelcomeViewControllerViewModel.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 11/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import Foundation

class WelcomeViewControllerViewModel {
    
    private let textsToShow = [
        WelcomeModel(primaryText: "Follow expenses",secondaryText: "from anywhere",imageName: "welcomeImage_1.png"),
        WelcomeModel(primaryText: "Find cheap places",secondaryText: "in seconds",imageName: "welcomeImage_2.png"),
        WelcomeModel(primaryText: "Share expenses",secondaryText: "with anyone",imageName: "welcomeImage_3.png")
    ]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfItemsInSection: Int {
        return textsToShow.count
    }
    
    func getElement(for index: Int) -> WelcomeModel {
        return textsToShow[index]
    }
}
