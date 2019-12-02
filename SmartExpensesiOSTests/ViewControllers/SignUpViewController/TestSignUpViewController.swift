//
//  TestSignUpViewController.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSignUpViewController: XCTestCase {

    var signUpViewController: SignUpViewController!
    
    override func setUp() {
        signUpViewController = SignUpViewController.instantiate()
        signUpViewController.viewModel = SignUpViewModel()
        signUpViewController.service = AuthorizationService()
        _ = signUpViewController.view //to call viewDidLoad()
    }
    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(signUpViewController.activityIndicator)
        XCTAssertNotNil(signUpViewController.closeScreenButton)
        XCTAssertNotNil(signUpViewController.emailAddressLabel)
        XCTAssertNotNil(signUpViewController.emailTextField)
        XCTAssertNotNil(signUpViewController.passwordTextField)
        XCTAssertNotNil(signUpViewController.passwordLabel)
        XCTAssertNotNil(signUpViewController.confirmPasswordLabel)
        XCTAssertNotNil(signUpViewController.confirmPasswordTextField)
        XCTAssertNotNil(signUpViewController.titleLabel)
        XCTAssertNotNil(signUpViewController.welcomeLabel)
        XCTAssertNotNil(signUpViewController.termsAndConditionsButton)
        XCTAssertNotNil(signUpViewController.termsAndConditionsLabel)
        XCTAssertNotNil(signUpViewController.signUpButton)
    }
    
    func testGetCredentialsFromTextFieldsEmailFieldIsNil() {
        signUpViewController.emailTextField.text = nil
        XCTAssertNil(signUpViewController.getCredentialsFromTextFields())
    }
    
    func testGetCredentialsFromTextFieldsPasswordFieldIsNil() {
        signUpViewController.passwordTextField.text = nil
        XCTAssertNil(signUpViewController.getCredentialsFromTextFields())
    }
    
    func testGetCredentialsFromTextFieldsConfirmPasswordFieldIsNil() {
        signUpViewController.confirmPasswordTextField.text = nil
        XCTAssertNil(signUpViewController.getCredentialsFromTextFields())
    }
    
    func testGetCredentialsFromTextFieldsWithGoodValues() {
        signUpViewController.emailTextField.text = "test@test.com"
        signUpViewController.passwordTextField.text = "Test1234"
        signUpViewController.confirmPasswordTextField.text = "Test1234"
        XCTAssertNotNil(signUpViewController.getCredentialsFromTextFields())
    }

}
