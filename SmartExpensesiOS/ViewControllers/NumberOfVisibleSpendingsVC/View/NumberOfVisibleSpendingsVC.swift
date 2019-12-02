//
//  NumberOfVisibleSpendingsVC.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class NumberOfVisibleSpendingsVC: UIViewController, StoryboardAble {
    
    @IBOutlet weak var selectionTableView: UITableView!
    var currentlySelectedIndex: Int = 0
    var numberSelectedClosure: ((Int) -> Void)?
    
    let elements = [5,6,7,8,9,10]

    override func viewDidLoad() {
        super.viewDidLoad()

        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSelection))
    }
    
    @objc func saveSelection() {
        numberSelectedClosure?(elements[currentlySelectedIndex])
    }

}

extension NumberOfVisibleSpendingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfVisibleSpendingsCell") else { return UITableViewCell() }
        if indexPath.row == currentlySelectedIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = "\(elements[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentlySelectedIndex = indexPath.row
        tableView.reloadData()
    }
}
