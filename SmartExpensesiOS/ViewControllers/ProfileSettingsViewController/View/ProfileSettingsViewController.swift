//
//  ProfileSettingsViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var profileRingView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var totalSpendingsLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "My Profile"
        tabBarItem = UITabBarItem(title: "My Profile", image: UIImage(named: "tabbar_4.png"), tag: 4)
    }
    
    var logOutClosure: (() -> Void)?
    let menuPoints = ["Notifications","Select profile colour","Number of latest spendings","Privacy","Terms & Conditions"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavbar()
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUI()
    }
    
    private func setUpTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
    }
    
    private func setUpUI() {
        profileRingView.asCircle()
        profileImageView.asCircle()
    }
    
    @objc func logOut() {
        LoginService.logOutUser()
        logOutClosure?()
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
    
    }
}

extension ProfileSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") else { return UITableViewCell() }
        cell.textLabel?.text = menuPoints[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 80))

            let label = UILabel()
            label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
            label.text = "Settings"
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 25.0)
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
        return 80.0
    }
}
