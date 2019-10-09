//
//  WelcomeViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    
    }
}
