//
//  TestSignUpViewModel.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSignUpViewModel: XCTestCase {

    var viewModel: SignUpViewModel!
    
    override func setUp() {
        viewModel = SignUpViewModel()
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
    
    func testPasswordVerificationRuleForValidParameters() {
        let password = "Test1234"
        let confirmation = "Test1234"
        XCTAssert((viewModel.validatePasswords(password: password, confirmation: confirmation) != nil))
    }
    
    func testPasswordVerificationRuleForNotSameParameters() {
        let password = "Test1234"
        let confirmation = "Test123"
        XCTAssert((viewModel.validatePasswords(password: password, confirmation: confirmation) == nil))
    }
    
    func testPasswordVerificationRuleForParameterWithOutLessThan8Chars() {
        let password = "test123"
        let confirmation = "test123"
        XCTAssertNil(viewModel.validatePasswords(password: password, confirmation: confirmation))
    }
    
    func testPasswordVerificationRuleForParameterWithOutNumerical() {
        let password = "testtest"
        let confirmation = "testtest"
        XCTAssertNil(viewModel.validatePasswords(password: password, confirmation: confirmation))
    }
    
    func testPasswordVerificationRuleForParameterWithOutLetters() {
        let password = "12345678"
        let confirmation = "12345678"
        XCTAssertNil(viewModel.validatePasswords(password: password, confirmation: confirmation))
    }

}
