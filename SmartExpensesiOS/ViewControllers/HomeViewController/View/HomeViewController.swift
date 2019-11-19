//
//  HomeViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 17/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardAble, AnimatableVC {
    
    @IBOutlet weak var mainTableView: UITableView!
    var addNewExpenseClosure: (() -> Void)?
    var refreshControl = UIRefreshControl()
    var service: HomeViewControllerService!
    var viewModel: HomeViewModel!
    
    var shouldLoadContent: Bool = true {
        didSet {
            if !shouldLoadContent {
                mainTableView.reloadData()
                refreshControl.endRefreshing()
                stopAnimation()
            } else {
                mainTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.delegate = self
        setUpNavbar()
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "Home"
        tabBarItem.image = UIImage(named: "tabbar_0.png")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isBeingPresented || self.isMovingToParent {
            service.fetchRecentExpenses(number: UserDefaults.numberOfLatestSpendings)
        }
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
        
        let contentLoadingNibObject = UINib.init(nibName: ContentLoadingCell.nibName, bundle: nil)
        mainTableView.register(contentLoadingNibObject, forCellReuseIdentifier: ContentLoadingCell.cellName)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.separatorStyle = .none
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        mainTableView.addSubview(refreshControl)
    }
    
    @objc func createNewExpense() {
        addNewExpenseClosure?()
    }
    
    @objc func refreshTableView() {
        shouldLoadContent = true
        service.fetchRecentExpenses(number: UserDefaults.numberOfLatestSpendings)
    }
}

extension HomeViewController: HomeDelegate {
    
    func didStartFetchingRecommendations() {
        startAnimation()
    }
    
    func didFinishFetchingRecommendations(recommendations: [Recommendation], expenses: [Expense]) {
        viewModel.refreshDataSource(recommendations: recommendations, expenses: expenses)
        shouldLoadContent = false
    }
    
    func didFailFetchingRecommendations(error: NetworkError) {
        shouldLoadContent = false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if shouldLoadContent {
            mainTableView.backgroundView = nil
            return 10
        } else {
            if viewModel.isExpensesEmpty {
                mainTableView.showEmptyTableViewMessage(message: "We couldn't find any expenses to show. Pull to refresh...")
            } else {
                mainTableView.backgroundView = nil
            }
            return viewModel.numberOfSections
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldLoadContent {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentLoadingCell.cellName) as? ContentLoadingCell else { return UITableViewCell() }
            return cell
        } else {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendationsTableViewCell.cellID, for: indexPath) as? HomeRecommendationsTableViewCell else { return UITableViewCell() }
                cell.recommendations = viewModel.getRecommendations()
                cell.recommendationsCollectionView.reloadData()
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseCell.cellName) as? ExpenseCell else { return UITableViewCell() }
                cell.currentExpense = viewModel.getExpense(for: indexPath.section - 1)
                return cell
            }
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
