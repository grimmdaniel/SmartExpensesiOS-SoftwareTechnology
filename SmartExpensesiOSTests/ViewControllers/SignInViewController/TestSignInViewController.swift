//
//  TestSignInViewController.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 03/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSignInViewController: XCTestCase {
    
    var signInViewController: SignInViewController!
    
    override func setUp() {
        signInViewController = SignInViewController.instantiate()
        signInViewController.viewModel = SignInViewModel()
        signInViewController.service = AuthorizationService()
        _ = signInViewController.view //to call viewDidLoad()
    }
    
    func testAllViewsAndSubviewsLoaded() {
        XCTAssertNotNil(signInViewController.activityIndicator)
        XCTAssertNotNil(signInViewController.closeScreenButton)
        XCTAssertNotNil(signInViewController.emailAddressLabel)
        XCTAssertNotNil(signInViewController.emailTextField)
        XCTAssertNotNil(signInViewController.passwordTextField)
        XCTAssertNotNil(signInViewController.passwordLabel)
        XCTAssertNotNil(signInViewController.forgotPasswordLabel)
        XCTAssertNotNil(signInViewController.signInButton)
        XCTAssertNotNil(signInViewController.titleLabel)
        XCTAssertNotNil(signInViewController.welcomeLabel)
    }
    
    func testInternalServerErrorInLoginServiceEndToEnd() {
        let actionDelegate = FakeLoginService()
        signInViewController.service = FakeFailureLoginService(error: .internalServerError, delegate: actionDelegate)
        signInViewController.service.delegate = actionDelegate
        
        signInViewController.emailTextField.text = "test@test.com"
        signInViewController.passwordTextField.text = "Test1234"
        
        signInViewController.signInButton.sendActions(for: .touchUpInside)
        guard let receivedError = actionDelegate.error else {
            XCTFail("Expected error of type InternalServerError but got nil")
            return
        }
        XCTAssertTrue(actionDelegate.isHandleErrorCalled , "The function handleError is not called.")
        XCTAssert(receivedError == NetworkError.internalServerError, "The function handleError is called but the error received as the argument in the function is wrong, Expected the error of type \(NetworkError.internalServerError) but got \(receivedError)")
    }
}

class FakeLoginService: AuthorizationDelegate {
    
    var isLoginSuccessFullCalled = false
    var isHandleErrorCalled = false
    var error: NetworkError? = nil
    
    func didStartAuthorization() {
        
    }
    
    func didFinishAuthorization(token: String, user: String) {
        isLoginSuccessFullCalled = true
    }
    
    func didFailToAuthorizeUser(error: NetworkError) {
        isHandleErrorCalled = true
        self.error = error
    }
}

class FakeFailureLoginService: AuthorizationService {
    
    let error: NetworkError
    
    init(error: NetworkError, delegate: AuthorizationDelegate) {
        self.error = error;
        super.init()
        self.delegate = delegate
    }
    
    override func loginUser(user: UserCredential) {
        delegate?.didFailToAuthorizeUser(error: error)
    }
  
}
