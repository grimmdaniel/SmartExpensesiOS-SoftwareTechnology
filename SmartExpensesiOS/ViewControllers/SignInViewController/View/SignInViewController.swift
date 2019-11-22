//
//  SignInViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, StoryboardAble {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeScreenButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var closeScreenClosure: (() -> Void)?
    var signInCompletedClosure: (() -> Void)?
    var service: AuthorizationService!
    var viewModel: SignInViewModel!
    
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        service.delegate = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        setUpActivityIndicator()
        setUpTextFieldBehaviour()
        setUpUI()
        setTranslations()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    private func setUpTextFieldBehaviour() {
        emailTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
    }
    
    private func setTranslations() {
        welcomeLabel.text = "signInScreenWelcomeLabelText".localized
        titleLabel.text = "signInScreenTitleText".localized
        emailAddressLabel.text = "signInScreenEmailLabel".localized
        passwordLabel.text = "signInScreenPasswordLabel".localized
        emailTextField.placeholder = "signInScreenEmailPlaceholder".localized
        passwordTextField.placeholder = "signInScreenPasswordPlaceholder".localized
        forgotPasswordLabel.text = "signInScreenForgotPassword".localized
        signInButton.setTitle("signInScreenSignInButtonText".localized, for: .normal)
    }
    
    private func setUpUI() {
        signInButton.layer.cornerRadius = 20.0
        emailTextField.layer.cornerRadius = 4.0
        passwordTextField.layer.cornerRadius = 4.0
        emailTextField.layer.masksToBounds = false
        emailTextField.layer.shadowRadius = 3.0
        emailTextField.layer.shadowColor = UIColor.black.cgColor
        emailTextField.layer.shadowOffset = CGSize(width: 1, height: 1)
        emailTextField.layer.shadowOpacity = 0.5
        passwordTextField.layer.masksToBounds = false
        passwordTextField.layer.shadowRadius = 3.0
        passwordTextField.layer.shadowColor = UIColor.black.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width: 1, height: 1)
        passwordTextField.layer.shadowOpacity = 0.5
    }
    
    private func getCredentialsFromTextFields() -> UserCredential? {
        guard let emailRaw = emailTextField.text else { return nil }
        guard let email = viewModel.validateEmailAddress(email: emailRaw) else {
            showErrorPopUp(title: "Warning", message: "Email format is not valid.")
            return nil
        }
        
        guard let passwordRaw = passwordTextField.text else { return nil }
        guard let password = viewModel.validatePasswords(password: passwordRaw) else {
            showErrorPopUp(title: "Warning", message: "Password has to contain at least 8 characters, with one capitalized letter, and a number.")
            return nil
        }
        let encryptedPassword = viewModel.encryptPass(pass: password)
        return UserCredential(email: email,password: encryptedPassword)
    }
    
    @IBAction func closeScreenButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let user = getCredentialsFromTextFields() else { return }
        service.loginUser(user: user)
    }
}

extension SignInViewController: AuthorizationDelegate {
    
    func didStartAuthorization() {
        activityIndicator.startAnimating()
    }
    
    func didFinishAuthorization(token: String, user: String) {
        activityIndicator.stopAnimating()
        LoginService.loginUser(token: token, user: user)
        signInCompletedClosure?()
    }
    
    func didFailToAuthorizeUser(error: NetworkError) {
        activityIndicator.stopAnimating()
        showErrorPopUp(title: "Error", message: error.localizedDescription)
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
}
