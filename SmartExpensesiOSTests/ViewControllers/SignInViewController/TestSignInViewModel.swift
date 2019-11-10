//
//  TestSignInViewModel.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 03/11/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSignInViewModel: XCTestCase {
    
    var viewModel: SignInViewModel!
    
    override func setUp() {
        viewModel = SignInViewModel()
    }
    
    func testEmailVerificationRuleForValidParameter() {
        let email = "test@test.com"
        XCTAssert((viewModel.validateEmailAddress(email: email) != nil))
    }
    
    func testEmailVerificationRuleForParameterWithOutAt() {
        let email = "testtest.com"
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testEmailVerificationRuleForParameterWithOutDot() {
        let email = "test@testcom"
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testEmailVerificationRuleForParameterWithOutAtAndDot() {
        let email = "testtestcom"
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testEmailVerificationRuleForParameterWithFirstPart() {
        let email = "@test.com"
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testEmailVerificationRuleForParameterWithOutSecondPart() {
        let email = "test@.com"
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testEmailVerificationRuleForParameterWithOutDomainEnd() {
        let email = "test@test."
        XCTAssertNil(viewModel.validateEmailAddress(email: email))
    }
    
    func testPasswordVerificationRuleForValidParameter() {
        let password = "Test1234"
        XCTAssert((viewModel.validatePasswords(password: password) != nil))
    }
    
    func testPasswordVerificationRuleForParameterWithOutLessThan8Chars() {
        let password = "test123"
        XCTAssertNil(viewModel.validatePasswords(password: password))
    }
    
    func testPasswordVerificationRuleForParameterWithOutNumerical() {
        let password = "testtest"
        XCTAssertNil(viewModel.validatePasswords(password: password))
    }
    
    func testPasswordVerificationRuleForParameterWithOutLetters() {
        let password = "12345678"
        XCTAssertNil(viewModel.validatePasswords(password: password))
    }
}
