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
    var selectedColor: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSelection))
    }
    
    @objc func saveSelection() {
        updateUserData(data: ["color":selectedColor ?? "#ffffff" ,"num_latest_spendings": self.elements[self.currentlySelectedIndex]])
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

extension NumberOfVisibleSpendingsVC {
    
    func updateUserData(data: [String:Any]) {
        let manager = NetworkManager()
        guard let apiKey = UserDefaults.APIKEY else { return }
        let httpObject = HTTPObject(
            type: .PUT,
            endpoint: .updateProfile,
            httpHeader: HTTPObject.createHeaderWithAuthentication(apiKey: apiKey),
            httpBody: data
        )
        
        manager.performNetworkRequest(with: httpObject) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    print(json)
                    guard let self = self else { return }
                    self.numberSelectedClosure?(self.elements[self.currentlySelectedIndex])
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
