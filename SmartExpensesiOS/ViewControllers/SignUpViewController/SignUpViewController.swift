//
//  SignUpViewController.swift
//  SmartExpensesiOS
//
//  Created by Grimm Dániel on 09/10/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, StoryboardAble {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeScreenButton: UIButton!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        emailTextField.returnKeyType = UIReturnKeyType.next
        passwordTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        setUpUI(for: [emailTextField,passwordTextField,confirmPasswordTextField])
        setTranslations()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    private func setTranslations() {
        titleLabel.text = "signUpScreenTitleText".localized
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
    
    @IBAction func closeScreenButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        closeScreenClosure?()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        print("terms and conditions pressed")
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
