//
//  TestSecurity.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestSecurity: XCTestCase {

    func testSHA256WithGoodParameters() {
        let passwordToEncode = "Test1234"
        let expectedResult = "07480fb9e85b9396af06f006cf1c95024af2531c65fb505cfbd0add1e2f31573"
        XCTAssertEqual(SHA256Encoder().encodePass(password: passwordToEncode), expectedResult)
    }
    
    func testSHA256WithWrongParameters() {
        let passwordToEncode = "Test1234"
        let expectedResult = "Test1234"
        XCTAssertNotEqual(SHA256Encoder().encodePass(password: passwordToEncode), expectedResult)
    }

}
