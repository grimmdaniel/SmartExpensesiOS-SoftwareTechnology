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

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        emailTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUpUI()
        setTranslations()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
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
    
    @IBAction func closeScreenButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        LoginService.loginUser(with: "asdasdasd")
        signInCompletedClosure?()
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
