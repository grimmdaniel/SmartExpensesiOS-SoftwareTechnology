//
//  SelectExpenseCategoryVC.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class SelectExpenseCategoryVC: UIViewController, StoryboardAble {

    @IBOutlet weak var customNavigationBar: UINavigationBar!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categorySelectedClosure: ((Int?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUPNavigationBar()
    }
    
    private func setUPNavigationBar() {
        let navigationItem = UINavigationItem(title: "Categories")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSelection))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSelection))
        customNavigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc func cancelSelection() {
        categorySelectedClosure?(nil)
    }
    
    @objc func saveSelection() {
        
    }
}
