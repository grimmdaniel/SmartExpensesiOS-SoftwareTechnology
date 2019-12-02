//
//  ProfileSettingsViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 22/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import SafariServices

class ProfileSettingsViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var profileRingView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var totalSpendingsLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    var currentProfileImage: UIImage! {
        didSet {
            profileImageView.image = currentProfileImage
        }
    }
    
    var currentColorCode: String! {
        didSet {
            profileRingView.backgroundColor = UIColor.hexStringToUIColor(hexCode: currentColorCode)
        }
    }
    
    var currentProfile: ProfileData? {
        didSet {
            if let data = currentProfile {
                print(data)
                currentProfileImage = data.profileImage
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        title = "My Profile"
        tabBarItem = UITabBarItem(title: "My Profile", image: UIImage(named: "tabbar_4.png"), tag: 4)
    }
    
    var logOutClosure: (() -> Void)?
    var colorPickerClosure: (() -> Void)?
    var activityIndicator = UIActivityIndicatorView()
    var service: LogoutService!
    var profileService: ProfileService!
    
    let menuPoints = ["Select profile colour","Number of latest spendings","Privacy","Terms & Conditions"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.delegate = self
        profileService.delegate = self
        setUpNavbar()
        setUpTableView()
        profileNameLabel.text = UserDefaults.USERNAME ?? "N/A"
        setUpActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUI()
        if self.isBeingPresented || self.isMovingToParent {
            profileService.fetchProfileData()
        }
    }
    
    private func setUpTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
    }
    
    private func setUpNavbar() {
        navigationController?.navigationBar.barTintColor = ColorTheme.primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }
    
    @objc func refresh() {
        profileService.fetchProfileData()
    }
    
    private func setUpUI() {
        profileRingView.asCircle()
        profileImageView.asCircle()
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addNewImage)))
    }
    
    private func openDocumentsInBrowser(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @objc func logOut() {
        logOutPressed()
    }
    
    @objc func addNewImage() {
        let optionMenu = UIAlertController(title: nil, message: "Select image", preferredStyle: .actionSheet)
        let browseAction = UIAlertAction(title: "Browse gallery", style: .default) { [weak self] (_) in
            self?.addImageFromLibrary()
        }
        let createImageAction = UIAlertAction(title: "Create new", style: .default) { [weak self] (_) in
            self?.createNewPhoto()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(browseAction)
        optionMenu.addAction(createImageAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func addImageFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func createNewPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func logOutPressed() {
        guard let apikey = UserDefaults.APIKEY else { return }
        let alertVC = UIAlertController(title: "Confirmation", message: "Are you sure want to log out?", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] (_) in
            self?.service.logOutUser(apiKey: apikey)
        }))
        present(alertVC, animated: true, completion: nil)
    }
}

extension ProfileSettingsViewController: LogoutDelegate {
    
    func didStartAuthorization() {
        activityIndicator.startAnimating()
    }
    
    func didFinishAuthorization() {
        activityIndicator.stopAnimating()
        LoginService.logOutUser()
        logOutClosure?()
    }
    
    func didFailToAuthorizeUser(error: NetworkError) {
        activityIndicator.stopAnimating()
        showErrorPopUp(title: "Error", message: error.localizedDescription)
    }
}

extension ProfileSettingsViewController: ProfileDataDelegate {
    
    func didStartFetchingProfileData() {
        activityIndicator.startAnimating()
    }
    
    func didFinishFetchingProfileData(data: ProfileData) {
        currentProfile = data
        activityIndicator.stopAnimating()
    }
    
    func didFailToFetchProfileData(error: NetworkError) {
        activityIndicator.stopAnimating()
    }
    
}

extension ProfileSettingsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let resizedImage = pickedImage.resizeImage(newWidth: 300)
            currentProfileImage = resizedImage
            let base64EncodedImage = resizedImage.encodeImageToBase64()
            print(base64EncodedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            colorPickerClosure?()
        } else if indexPath.row == 2 {
            openDocumentsInBrowser(url: "https://google.com")
        } else if indexPath.row == 3 {
            openDocumentsInBrowser(url: "https://google.com")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
}
