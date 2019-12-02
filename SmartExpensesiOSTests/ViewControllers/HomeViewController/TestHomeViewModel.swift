//
//  TestHomeViewModel.swift
//  SmartExpensesiOSTests
//
//  Created by Grimm Dániel on 02/12/2019.
//  Copyright © 2019 com.daniel.grimm.smartexpenses. All rights reserved.
//

import XCTest
import CoreLocation
@testable import SmartExpensesiOS

class TestHomeViewModel: XCTestCase {

    var viewModel: HomeViewModel!
    
    override func setUp() {
        viewModel = HomeViewModel()
    }
    
    private func fillUpDataSource() {
        let recommendations = [
            Recommendation(id: 1, imagePath: "", websiteURL: ""),
            Recommendation(id: 2, imagePath: "", websiteURL: ""),
            Recommendation(id: 3, imagePath: "", websiteURL: ""),
        ]
        
        let expenses = [
            Expense(id: 0, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0),
            Expense(id: 1, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0),
            Expense(id: 2, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0)
        ]
        
        viewModel.refreshDataSource(recommendations: recommendations, expenses: expenses)
    }

    func testEmptyDataSet() {
        XCTAssertEqual(viewModel.isExpensesEmpty, true)
    }
    
    func testDataSetFillUp() {
        fillUpDataSource()
        XCTAssertEqual(viewModel.numberOfSections, 4)
        XCTAssertEqual(viewModel.numberOfRowsInSection, 1)
    }
    
    func testAddElementToDatSet() {
        fillUpDataSource()
        viewModel.addNewExpense(expense: Expense(id: 2, location: ExpenseLocation(latitude: 0, longitude: 0, address: ""), currency: ExpenseCurrency(currency: "HUF", value: 100, valueInUSD: 0.3), categoryID: 1, isPrivate: true, title: "", date: 0.0))
        XCTAssertEqual(viewModel.numberOfSections, 5)
        XCTAssertEqual(viewModel.numberOfRowsInSection, 1)
    }
    
}
