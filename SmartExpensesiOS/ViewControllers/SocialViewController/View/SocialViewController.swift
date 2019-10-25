//
//  SocialViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import MapKit

class SocialViewController: UIViewController, StoryboardAble {
    
    @IBOutlet weak var socialMapView: MKMapView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "Social"
        tabBarItem.image = UIImage(named: "tabbar_2.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
