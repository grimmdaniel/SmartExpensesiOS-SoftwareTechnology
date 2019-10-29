//
//  MyExpensesViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class MyExpensesViewController: UIViewController, StoryboardAble, AnimatableVC {
    
    @IBOutlet weak var myExpensesTableView: UITableView!
    
    var isLoadingContent: Bool = true {
        didSet {
            myExpensesTableView.reloadData()
            if isLoadingContent {
                startAnimation()
            } else {
                stopAnimation()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "MyExpenses"
        tabBarItem.image = UIImage(named: "tabbar_1.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        let expenseNibObject = UINib.init(nibName: ExpenseCell.nibName, bundle: nil)
        myExpensesTableView.register(expenseNibObject, forCellReuseIdentifier: ExpenseCell.cellName)
        
        let contentLoadingNibObject = UINib.init(nibName: ContentLoadingCell.nibName, bundle: nil)
        myExpensesTableView.register(contentLoadingNibObject, forCellReuseIdentifier: ContentLoadingCell.cellName)
        
        myExpensesTableView.delegate = self
        myExpensesTableView.dataSource = self
        myExpensesTableView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animation", style: .plain, target: self, action: #selector(startStopAnimating(_:)))
    }
    
    @objc func startStopAnimating(_ sender: UIBarButtonItem) {
        isLoadingContent.toggle()
    }
}

extension MyExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingContent {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentLoadingCell.cellName) as? ContentLoadingCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.cellName) as? ExpenseCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
