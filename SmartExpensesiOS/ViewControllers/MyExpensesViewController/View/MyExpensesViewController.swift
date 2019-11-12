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
    var addNewExpenseClosure: (() -> Void)?
    var refreshControl = UIRefreshControl()
    var service: MyExpensensesService!
    
    var expenses = [Expense]()
    
    var shouldLoadContent: Bool = true {
        didSet {
            if !shouldLoadContent {
                myExpensesTableView.reloadData()
                refreshControl.endRefreshing()
                stopAnimation()
            } else {
                myExpensesTableView.reloadData()
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        myExpensesTableView.addSubview(refreshControl)
        
        service.delegate = self
    }
    
    @objc func refreshTableView() {
        shouldLoadContent = true
        service.fetchAllExpenses()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isBeingPresented || self.isMovingToParent {
            service.fetchAllExpenses()
        }
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewExpense))
    }
    
    @objc func createNewExpense() {
        addNewExpenseClosure?()
    }
}

extension MyExpensesViewController: MyExpensesDelegate {
    
    func didStartFetchingExpenses() {
        startAnimation()
    }
    
    func didFinishFetchingExpenses(expenses: [Expense]) {
        self.expenses = expenses
        shouldLoadContent = false
    }
    
    func didFailFetchingExpenses(error: NetworkError) {
        shouldLoadContent = false
    }
}

extension MyExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if shouldLoadContent {
            tableView.backgroundView = nil
            return 10
        } else {
            if expenses.isEmpty {
                tableView.showEmptyTableViewMessage(message: "We couldn't find any expenses to show. Pull to refresh...")
            } else {
                tableView.backgroundView = nil
            }
            return expenses.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldLoadContent {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentLoadingCell.cellName) as? ContentLoadingCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.cellName) as? ExpenseCell else { return UITableViewCell() }
            cell.currentExpense = expenses[indexPath.section]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
