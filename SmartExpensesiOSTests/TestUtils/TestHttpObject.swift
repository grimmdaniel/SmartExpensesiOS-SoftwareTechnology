//
//  TestHttpObject.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
@testable import SmartExpensesiOS

class TestHttpObject: XCTestCase {
    
    var httpObject: HTTPObject!

    override func setUp() {
     
    }
    
    func testHeaderGeneration() {
        let apikey = "123456789"
        let json = [
            "Authorization": "Bearer 123456789",
            "Content-Type": "application/json"
        ]
        XCTAssertEqual(json, HTTPObject.createHeaderWithAuthentication(apiKey: apikey))
    }
    
    func testWithOutParameter() {
        httpObject = HTTPObject(
            type: .GET,
            endpoint: .deleteExpense,
            httpHeader: [:],
            httpBody: [:]
        )
        XCTAssertEqual(httpObject.type, HTTPMethod.GET)
        XCTAssertEqual(httpObject.urlString, "https://smarte-flask.herokuapp.com/expense/delete")
    }
    
    func testParameterAddition() {
        let userID = 10
        httpObject = HTTPObject(
            type: .GET,
            endpoint: .deleteExpense,
            urlParameter: userID,
            httpHeader: [:],
            httpBody: [:]
        )
        XCTAssertEqual(httpObject.type, HTTPMethod.GET)
        XCTAssertEqual(httpObject.urlString, "https://smarte-flask.herokuapp.com/expense/delete/10")
    }
}
