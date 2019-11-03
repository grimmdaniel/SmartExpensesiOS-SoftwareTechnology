//
//  SignUpViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit
import SafariServices

class SignUpViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeScreenButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    
    var closeScreenClosure: (() -> Void)?
    var signUpCompletedClosure: (() -> Void)?
    var viewModel: SignUpViewModel!
    var service: AuthorizationService!
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.delegate = self
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        setUpActivityIndicator()
        setUpTextFieldBehaviour()
        setUpUI(for: [emailTextField,passwordTextField,confirmPasswordTextField])
        setTranslations()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    private func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
    }
    
    private func setUpTextFieldBehaviour() {
        emailTextField.returnKeyType = UIReturnKeyType.next
        passwordTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    private func setTranslations() {
        titleLabel.text = "signUpScreenTitleText".localized
        welcomeLabel.text = "signUpScreenWelcomeText".localized
        emailAddressLabel.text = "signUpScreenEmailLabel".localized
        emailTextField.placeholder = "signUpScreenEmailPlaceholder".localized
        passwordLabel.text = "signUpScreenPasswordLabel".localized
        passwordTextField.placeholder = "signUpScreenPasswordPlaceholder".localized
        confirmPasswordLabel.text = "signUpScreenConfirmPasswordLabel".localized
        confirmPasswordTextField.placeholder = "signUpScreenConfirmPasswordPlaceholder".localized
        signUpButton.setTitle("signUpScreenSignUpButtonText".localized, for: .normal)
        termsAndConditionsLabel.text = "signUpScreenTermsAndConditionsLabel".localized
        termsAndConditionsButton.setTitle("signUpScreenTermsAndConditionsButton".localized, for: .normal)
    }
    
    private func setUpUI(for textfields: [UITextField]) {
        signUpButton.layer.cornerRadius = 20.0
        for textField in textfields {
            textField.layer.cornerRadius = 4.0
            textField.layer.masksToBounds = false
            textField.layer.shadowRadius = 3.0
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOffset = CGSize(width: 1, height: 1)
            textField.layer.shadowOpacity = 0.5
        }
    }
    
    private func getCredentialsFromTextFields() -> UserCredential? {
        guard let emailRaw = emailTextField.text else { return nil }
        guard let email = viewModel.validateEmailAddress(email: emailRaw) else {
            showErrorPopUp(title: "Warning", message: "Email format is not valid.")
            return nil
        }
        
        guard let passwordRaw = passwordTextField.text else { return nil }
        guard let confirmedPasswordRaw = confirmPasswordTextField.text else { return nil }
        guard let password = viewModel.validatePasswords(password: passwordRaw, confirmation: confirmedPasswordRaw) else {
            showErrorPopUp(title: "Warning", message: "Password has to contain at least 8 characters, with one capitalized letter, and a number. Password and password confirmation must be the same.")
            return nil
        }
        
        return UserCredential(email: email,password: password)
    }
    
    private func openTermsAndConditions() {
        let safariViewController = SFSafariViewController(url: URL(string: "https://www.termsandconditionsgenerator.com")!)
        present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func closeScreenButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let user = getCredentialsFromTextFields() else { return }
        service.registerUser(user: user)
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        openTermsAndConditions()
    }
}

extension SignUpViewController: AuthorizationDelegate {
    
    func didStartAuthorization() {
        activityIndicator.startAnimating()
    }
    
    func didFinishAuthorization(token: String, user: String) {
        activityIndicator.stopAnimating()
        LoginService.loginUser(token: token, user: user)
        signUpCompletedClosure?()
    }
    
    func didFailToAuthorizeUser(error: NetworkError) {
        activityIndicator.stopAnimating()
        showErrorPopUp(title: "Error", message: error.localizedDescription)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        return true
    }
}
