//
//  AddNewExpenseViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 07/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class AddNewExpenseViewController: UIViewController, StoryboardAble {

    var closeScreenClosure: (() -> Void)?
    
    @IBOutlet weak var transparentBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        transparentBackgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        mainBackgroundView.layer.cornerRadius = 10.0
    
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
