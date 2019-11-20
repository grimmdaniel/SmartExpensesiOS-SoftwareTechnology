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
    
    var categorySelectedClosure: ((CategorySelection?) -> Void)?
    var currentlySelectedCategory = 0
    private let cellID = "ExpenseCategoryCell"
    let categoryRepository = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUPNavigationBar()
        setUpTableView()
    }
    
    private func setUpTableView() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.tableFooterView = UIView.init(frame: CGRect.zero)
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
        categorySelectedClosure?((currentlySelectedCategory,categoryRepository.categories[currentlySelectedCategory]))
    }
}

extension SelectExpenseCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryRepository.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else { return UITableViewCell() }
        cell.textLabel?.text = categoryRepository.categories[indexPath.row]
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        cell.accessoryType = indexPath.row == currentlySelectedCategory ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIndex = currentlySelectedCategory
        currentlySelectedCategory = indexPath.row
        tableView.reloadRows(at: [IndexPath(row: oldIndex, section: 0),IndexPath(row: currentlySelectedCategory, section: 0)], with: .automatic)
    }
}

typealias CategorySelection = (categoryID: Int, categoryName: String)
