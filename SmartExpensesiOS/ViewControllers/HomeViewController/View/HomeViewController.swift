//
//  HomeViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardAble {
    
    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "Home"
        tabBarItem.image = UIImage(named: "tabbar_0.png")
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewExpense))
    }
    
    private func setUpTableView() {
        let nibObject = UINib.init(nibName: ExpenseCell.nibName, bundle: nil)
        mainTableView.register(nibObject, forCellReuseIdentifier: ExpenseCell.cellName)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .none
    }
    
    @objc func createNewExpense() {
        print("Creating new expense...")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendationsTableViewCell.cellID, for: indexPath) as? HomeRecommendationsTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.cellName) as? ExpenseCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 80))

            let label = UILabel()
            label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
            if section == 0 {
                label.text = "Cheap places to explore nearby..."
            } else {
                label.text = "Latest spendings"
            }
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 27.0)
            label.textColor = ColorTheme.secondaryColor
            label.numberOfLines = 2

            headerView.addSubview(label)
            return headerView
        } else {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 80.0
        }
        return 5.0
    }
}
